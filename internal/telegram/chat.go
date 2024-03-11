package telegram

import (
	"fmt"
	"time"

	tb "gopkg.in/telebot.v3"
	db "github.com/doodler8888/shelf/internal/database"
)

func AskQuestions(b *tb.Bot, chatID int64) (db.Book, error) {
	var book db.Book

	// Create channels to receive responses
	authorChan := make(chan string)
	titleChan := make(chan string)

	authorMessage, err := b.Send(tb.ChatID(chatID), "What is the author's name?")
	if err != nil {
		return book, fmt.Errorf("failed to send message: %v", err)
	}

	// Register a handler for the author response
	b.Handle(tb.OnText, func(c tb.Context) error {
		if c.Message().ReplyTo.ID == authorMessage.ID {
			authorChan <- c.Message().Text
		}
		return nil
	})

	titleMessage, err := b.Send(tb.ChatID(chatID), "What is the book's name?")
	if err != nil {
		return book, fmt.Errorf("failed to send message: %v", err)
	}

	// Register a handler for the title response
	b.Handle(tb.OnText, func(c tb.Context) error {
		if c.Message().ReplyTo.ID == titleMessage.ID {
			titleChan <- c.Message().Text
		}
		return nil
	})

	// Wait for the responses
	book.Author = <-authorChan
	book.Title = <-titleChan

	book.FilePath = ""
	book.UploadedAt = time.Now()

	fmt.Printf("Populated Book struct: %+v\n", book)

	return book, nil
}
