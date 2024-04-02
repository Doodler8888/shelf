package telegram

import (
    "context"
    "fmt"
    "strconv"
    "time"
    "net/url"
    "strings"

    db "github.com/doodler8888/shelf/internal/database"
    tb "gopkg.in/telebot.v3"
    awst "github.com/doodler8888/shelf/internal/aws"
    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/config"
    // "github.com/aws/aws-sdk-go-v2/service/s3"
)

// Assuming you have a function to get the AWS configuration
func getAWSConfig() aws.Config {
    // Load your AWS configuration here
    cfg, err := config.LoadDefaultConfig(context.Background())
    if err != nil {
        panic("configuration error, " + err.Error())
    }
    return cfg
}

func ProcessBookName(c tb.Context, m *tb.Message) ([]*db.Book, error) {
	ctx := context.Background()
	books, err := db.GetBooksByTitle(ctx, m.Text)
	if err != nil || len(books) == 0 {
		c.Send("Sorry, I couldn't find any books matching your query.")
		return nil, err
	}

	response := "Found the following books:\n"
	for _, book := range books {
		bookDetails := fmt.Sprintf("ID: %d\nTitle: %s\nAuthor: %s\nUploaded At: %s\n---", book.ID, book.Title, book.Author, book.UploadedAt.Format(time.RFC1123))
		response += bookDetails + "\n"
	}
	response += "Please enter the ID of the book you want to choose:"
	c.Send(response)

	return books, nil
}

// func HandleBookSelection(c tb.Context, m *tb.Message, books []*db.Book) {
// 	bookID, err := strconv.ParseInt(m.Text, 10, 64)
// 	if err != nil {
// 		c.Send("Invalid ID. Please enter a valid book ID.")
// 		return
// 	}
//
// 	for _, book := range books {
// 		if book.ID == bookID {
// 			c.Send(fmt.Sprintf("You have selected: %s", book.Title))
// 			return
// 		}
// 	}
//
// 	c.Send("No book found with the provided ID. Please try again.")
// }

func HandleBookSelection(c tb.Context, m *tb.Message, books []*db.Book) {
    bookID, err := strconv.ParseInt(m.Text, 10, 64)
    if err != nil {
        c.Send("Invalid ID. Please enter a valid book ID.")
        return
    }

    var selectedBook *db.Book
    for _, book := range books {
        if book.ID == bookID {
            selectedBook = book
            break
        }
    }

    if selectedBook == nil {
        c.Send("No book found with the provided ID. Please try again.")
        return
    }

    c.Send(fmt.Sprintf("You have selected: %s", selectedBook.Title))

    // Extract the path from the full URL and remove the leading slash
    parsedURL, err := url.Parse(selectedBook.FilePath)
    if err != nil {
        c.Send("Failed to parse the file path. Please try again later.")
        return
    }
    keyName := strings.TrimPrefix(parsedURL.Path, "/")

    // Generate a pre-signed URL for the selected book
    cfg := getAWSConfig()
    bucketName := "shelf-bucket" // Replace with your actual bucket name
    presignedURL, err := awst.GetPresignURL(cfg, bucketName, keyName)
    if err != nil {
        c.Send("Failed to generate pre-signed URL. Please try again later.")
        return
    }

    // Send the pre-signed URL to the user
    c.Send(fmt.Sprintf("Download your book here: %s", presignedURL))
}

func HandleShowCommand(b *tb.Bot, c tb.Context) {
	// Directly ask the user for the book name
	err := c.Send("Please enter the book name:")
	if err != nil {
		fmt.Println("Error sending message:", err)
		return
	}

	// Initialize state to track whether we're expecting a book name or an ID
	var expectingBookName = true
	var books []*db.Book

	// Define a local function to handle the next message
	handleMessage := func(m *tb.Message) {
		if expectingBookName {
			// Process the book name and show the list of books
			var err error
			books, err = ProcessBookName(c, m)
			if err != nil || books == nil {
				// Error handling or no books found, stop further processing
				return
			}
			// Now expecting an ID, not a book name
			expectingBookName = false
		} else {
			// Handle the book ID selection
			HandleBookSelection(c, m, books)
			// Reset the state to be ready for the next book name query
			expectingBookName = true
		}
	}

	// Register the local function as the handler for the next message
	// Note: This registration overrides the global text message handler temporarily
	b.Handle(tb.OnText, func(c tb.Context) error {
		handleMessage(c.Message())
		return nil
	})
}
