package telegram

import (
	"fmt"
	"time"

	db "github.com/doodler8888/shelf/internal/database"
	tb "gopkg.in/telebot.v3"
)

func AskQuestions(b *tb.Bot, chatID int64) (db.Book, error) {
    var book db.Book
    var state int

    b.Handle(tb.OnText, func(c tb.Context) error {
        switch state {
        case 0:
            book.Author = c.Message().Text
            state = 1
            _, err := b.Send(tb.ChatID(chatID), "What is the book's name?")
            if err != nil {
                return err
            }
        case 1:
            book.Title = c.Message().Text
            state = 2
        }
        return nil
    })

    // Ask for the author's name
    _, err := b.Send(tb.ChatID(chatID), "What is the author's name?")
    if err != nil {
        return book, fmt.Errorf("failed to send message: %v", err)
    }

    // Wait for the responses
    for state != 2 {
        time.Sleep(time.Second)
    }

    // Fill out the remaining fields of the Book struct
    book.FilePath = ""
    book.UploadedAt = time.Now()

    return book, nil
}
