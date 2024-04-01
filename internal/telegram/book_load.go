package telegram

import (
	"fmt"
	"time"

	db "github.com/doodler8888/shelf/internal/database"
	tb "gopkg.in/telebot.v3"
)

func HandleUploadCommand(b *tb.Bot, chatID int64) (db.Book, error) {

	var book db.Book
	answerChan := make(chan string)

	// Define a sequence of questions and corresponding actions
	questionsAndActions := []struct { // This is a slice of structs, hence the struct is layered.
		question string
		action   func(answer string)
	}{
		{"What is the author's name?", func(answer string) { book.Author = answer }}, // Comma serves as a separator. The question string goes to the question field, the function goes to the action field.
		{"What is the book's name?", func(answer string) { book.Title = answer }},
	}

	// The handler triggers on my any text message and sends them to the channel until the
	// AskQuestions function stops working, becasue it's asyncronous. It doesn't
	// care what happens inside the function, it closes only with the function.
	b.Handle(tb.OnText, func(c tb.Context) error { // It's
		// c.Message().Text sends the received text to the channel
		answerChan <- c.Message().Text
		return nil
	})

	// Iterate over the questions and actions
	for _, qa := range questionsAndActions { // 'range' returns two values: index and value.
		// Ask the question
		_, err := b.Send(tb.ChatID(chatID), qa.question)
		if err != nil {
			return book, fmt.Errorf("failed to send message: %v", err)
		}

		// Wait for the answer
		answer := <-answerChan // This part blocks the loop until i answer.

		// Execute the action associated with the question
		qa.action(answer)
	}

	// Fill out the remaining fields of the Book struct
	book.FilePath = ""
	book.UploadedAt = time.Now()

	return book, nil
}
