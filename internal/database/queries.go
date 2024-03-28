package database

import (
  "context"
)


func InsertBook(ctx context.Context, newBook *Book) error {
    _, err := db.NewInsert().Model(newBook).Exec(ctx)
    return err
}


func GetBook(ctx context.Context, bookID int64) (*Book, error) {
    // Initialize an empty Book struct to hold the result
    book := new(Book)

    // Construct the query using Bun
    err := db.NewSelect().
        Model(book).
        Where("id = ?", bookID).
        Scan(ctx) // Execute the query and populate 'book'

    if err != nil {
        return nil, err // Return an error if the query fails
    }

    return book, nil // Return the retrieved book
}

