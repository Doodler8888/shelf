package telegram

import (
	"fmt"
	"time"

	db "github.com/doodler8888/shelf/internal/database"
	tb "gopkg.in/telebot.v3"
)

func AskQuestions(b *tb.Bot, chatID int64) (db.Book, error) {
	var book db.Book

	// Create channels to receive responses
	authorChan := make(chan string)
	titleChan := make(chan string)

	// Ask for the author name
	authorMessage, err := b.Send(tb.ChatID(chatID), "What is the author's name?")
	if err != nil {
		return book, fmt.Errorf("failed to send message: %v", err)
	}

	// Register a handler for the author response
	fmt.Println("Before executing the first handler")
	b.Handle(tb.OnText, func(c tb.Context) error {
		if c.Message().ReplyTo != nil && c.Message().ReplyTo.ID == authorMessage.ID {
			fmt.Println("Waiting for author response")
			authorChan <- c.Message().Text
			fmt.Println("Received author response")
			return nil
		}
		return nil
	})
	book.Author = <-authorChan

	// Ask for the book name
	titleMessage, err := b.Send(tb.ChatID(chatID), "What is the book's name?")
	if err != nil {
		return book, fmt.Errorf("failed to send message: %v", err)
	}

	// Register a handler for the title response
	b.Handle(tb.OnText, func(c tb.Context) error {
		if c.Message().ReplyTo != nil && c.Message().ReplyTo.ID == titleMessage.ID {
			titleChan <- c.Message().Text
			return nil
		}
		return nil
	})

	// Wait for the responses
	book.Title = <-titleChan

	// Fill out the remaining fields of the Book struct
	book.FilePath = ""
	book.UploadedAt = time.Now()

	return book, nil
}
