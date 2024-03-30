package telegram

import (
	"context"
	"fmt"
	"time"

	db "github.com/doodler8888/shelf/internal/database"
	tb "gopkg.in/telebot.v3"
)

func HandleShowCommand(b *tb.Bot, c tb.Context) {
	// Ask the user for the book name
	err := c.Send("Please enter the book name:")
	if err != nil {
		fmt.Println("Error sending message:", err)
		return
	}

	// Setup a one-time listener for the next message from this user
	// The listener is passed to the handler further in the
	// HandleShowCommand function, so don't question the usage of
	// '*tb.Message' as an argument.
	listener := func(m *tb.Message) {
		// Unregister the handler to prevent it from consuming all text messages
		b.Handle(tb.OnText, nil)

		ctx := context.Background() // Use appropriate context
		bookName := m.Text

		// Search for the book by title
		book, err := db.GetBookByTitle(ctx, bookName)
		if err != nil {
			c.Send("Sorry, I couldn't find the book.")
			return
		}

		// Send the book details back to the user
		bookDetails := fmt.Sprintf("Title: %s\nAuthor: %s\nUploaded At: %s", book.Title, book.Author, book.UploadedAt.Format(time.RFC1123))
		c.Send(bookDetails)
	}

	// Register the listener
	b.Handle(tb.OnText, tb.HandlerFunc(func(c tb.Context) error {
		listener(c.Message())
		return nil
	}))
}
