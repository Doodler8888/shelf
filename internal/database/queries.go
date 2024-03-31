package database

import (
  "context"
)


func InsertBook(ctx context.Context, newBook *Book) error {
    _, err := db.NewInsert().Model(newBook).Exec(ctx)
    return err
}


func GetBooksByTitle(ctx context.Context, title string) ([]*Book, error) {
    var books []*Book

    err := db.NewSelect(). // The dots at the end of each line indicate method chaining.
	Model(&books).
	Where("title ILIKE ?", "%"+title+"%"). // ILIKE servers for case insensitive search, the pattern matching does the rest of the work which in sum allows for some sort of a fuzzy search.
        Scan(ctx)

    if err != nil {
        return nil, err
    }

    return books, nil
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

// Scan selects only the first appearence of an item. But if it's used with a
// slice, it starts to return mutliple items.
