package main

import (
	"context"
	"log"
	"os"
	"path/filepath"
	"strings"

	aws "github.com/doodler8888/shelf/internal/aws"
	db "github.com/doodler8888/shelf/internal/database"
	tg "github.com/doodler8888/shelf/internal/telegram"
	tb "gopkg.in/telebot.v3"
)

func main() {
	db.InitDB()
	var (
		port      = "8080"
		publicURL = "https://f07b-178-121-0-35.ngrok-free.app"
		token     = os.Getenv("SHELF_TOKEN")
	)

	webhook := &tb.Webhook{
		Listen:   ":" + port,
		Endpoint: &tb.WebhookEndpoint{PublicURL: publicURL},
	}

	pref := tb.Settings{
		Token:  token,
		Poller: webhook,
	}

	b, err := tb.NewBot(pref)
	if err != nil {
		log.Fatalln(err)
	}

	b.Handle("/start", func(c tb.Context) error {
		return c.Send("Hi!")
	})

	b.Handle("/show", func(c tb.Context) error {
		tg.HandleShowCommand(b, c)
		return nil // Because the signature returns error, i have to actually return anything, even if there is no error.
	})

	var awaitingUpload = make(map[int64]bool)
	b.Handle("/upload", func(c tb.Context) error {
		// Indicate that the user is expected to upload a file next
		awaitingUpload[c.Sender().ID] = true
		return c.Send("Please upload the book file (PDF, EPUB, etc.).")
	})

	b.Handle(tb.OnDocument, func(c tb.Context) error {
	  userID := c.Sender().ID

	  if !awaitingUpload[userID] {
	    return c.Send("Please use the /upload command before uploading a file.")
	  }

	  file := c.Message().Document
	  ext := strings.ToLower(filepath.Ext(file.FileName)) // Normalize extension to lowercase

	  if ext == ".pdf" || ext == ".epub" {
	    localFilename := "/home/wurfkreuz/Downloads/shelf_s3/" + file.FileName

	    // Assuming HandleUploadCommand populates the book record except for FilePath
	    record, err := tg.HandleUploadCommand(b, c.Chat().ID)
	    if err != nil {
	      log.Printf("Error asking questions: %v", err)
	      return c.Send("An error occurred while processing the book.")
	    }

	    // Download the file
	    err = b.Download(&file.File, localFilename)
	    if err != nil {
	      log.Printf("Error downloading file: %v", err)
	      return c.Send("Failed to download the file.")
	    }
	    defer os.Remove(localFilename) // Ensure the local file is deleted after processing

	    // Read the file into a byte slice
	    fileBytes, err := os.ReadFile(localFilename)
	    if err != nil {
	      log.Printf("Error reading file: %v", err)
	      return c.Send("Failed to read the downloaded file.")
	    }

	    // Create an S3 client and upload the file
	    s3Client, err := aws.NewS3Client(context.Background())
	    if err != nil {
	      log.Printf("Error creating S3 client: %v", err)
	      return c.Send("Failed to connect to file storage.")
	    }

	    s3Path := "books/" + filepath.Base(localFilename)
	    err = aws.UploadFileToS3(context.Background(), s3Client, "shelf-bucket", s3Path, fileBytes)
	    if err != nil {
	      log.Printf("Error uploading file to S3: %v", err)
	      return c.Send("Failed to upload the file.")
	    }

	    // Set the FilePath field to the S3 path
	    record.FilePath = "https://shelf-bucket.s3.amazonaws.com/" + s3Path

	    // Insert the book record into the database
	    err = db.InsertBook(context.Background(), &record)
	    if err != nil {
	      log.Printf("Error inserting book into the database: %v", err)
	      return c.Send("An error occurred while saving the book.")
	    }

	    delete(awaitingUpload, userID) // Reset the user's state
	    return c.Send("Book uploaded successfully!")
	  } else {
	    delete(awaitingUpload, userID) // Reset the user's state even if the file format is invalid
	    return c.Send("Invalid file format. Please upload a book file (PDF, EPUB, etc.).")
	  }
	})


	b.Start()
}
