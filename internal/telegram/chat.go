package telegram

import (
    // tb "gopkg.in/telebot.v3"
    db "github.com/doodler8888/shelf/internal/database"
)

func AskQuestions(book db.Book) (db.Book, error) {
    // Create a copy of the original Book struct
    bookCopy := book

    // Modify the fields of the bookCopy as needed
    bookCopy.Title = "New Title"
    bookCopy.Author = "New Author"

    // Return the modified copy and any error if applicable
    return bookCopy, nil
}
