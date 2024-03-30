package database

import (
  "context"
)


func InsertBook(ctx context.Context, newBook *Book) error {
    _, err := db.NewInsert().Model(newBook).Exec(ctx)
    return err
}


func GetBookByTitle(ctx context.Context, title string) (*Book, error) {
    book := new(Book)

    err := db.NewSelect().
        Model(book).
        Where("title = ?", title).
        Scan(ctx)

    if err != nil {
        return nil, err
    }

    return book, nil
}


// .Where("title = ?", title) adds a WHERE clause to the query, specifying the
// condition to filter the books by title. The ? is a placeholder for the title
// parameter.

// When you execute the query using .Scan(ctx), the bun ORM performs the following steps:
//
// It sends the SQL query to the database to retrieve the book record that
// matches the specified title.
// If a matching book record is found, the ORM maps the values from the database
// columns to the corresponding fields of the book struct.
