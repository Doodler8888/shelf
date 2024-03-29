package main

import (
	"context"
	"log"
	"os"
	"path/filepath"

	db "github.com/doodler8888/shelf/internal/database"
	tg "github.com/doodler8888/shelf/internal/telegram"
	tb "gopkg.in/telebot.v3"
)

func main() {
	db.InitDB()
	var (
		port      = "8080"
		publicURL = "https://4a71-178-121-39-70.ngrok-free.app"
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

	// b.Handle(tb.OnText, func(c tb.Context) error {
	// 	return c.Send("Please upload a book file (PDF, EPUB, etc.).")
	// })

	b.Handle(tb.OnDocument, func(c tb.Context) error {
		file := c.Message().Document

		// Get the file extension
		ext := filepath.Ext(file.FileName)

		if ext == ".pdf" || ext == ".epub" {
			record, err := tg.AskQuestions(b, c.Chat().ID)
			if err != nil {
			  log.Printf("Error asking questions: %v", err)
			  return c.Send("An error occurred while processing the book.")
			}
			err = db.InsertBook(context.Background(), &record)
			if err != nil {
				log.Printf("Error inserting book into the database: %v", err)
				return c.Send("An error occurred while saving the book.")
			}
			return c.Send("Book uploaded successfully!")
		}
		return c.Send("Invalid file format. Please upload a book file (PDF, EPUB, etc.).")
	})

	b.Start()
}
