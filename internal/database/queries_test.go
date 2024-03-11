package database

import (
	"context"
	"testing"
	"time"
	// "os"
	// ... other imports
)

func TestInsertBook(t *testing.T) {
	// Test Setup (connect to your test database)
	ctx := context.Background() // For simplification during testing

	newBook := &Book{
		ID:       123,
		Title:    "Test Book",
		Author:   "Test Author",
		FilePath: "test/path",
		Uploaded_at: time.Now(),
	}

	err := InsertBook(ctx, newBook)

	if err != nil {
		t.Errorf("Error inserting book: %v", err)
	}

	// Optional: Query the test database to verify the book was inserted correctly
}
