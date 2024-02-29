package database

import (
	"testing"
	// "context"
	"github.com/uptrace/bun"
	"os"
)

var testDB *bun.DB // Your database connection for testing

func TestMain(m *testing.M) {
	// ... setup for your test database connection ...
	code := m.Run()
	// ... teardown code to close connection ...
	os.Exit(code)
}

func setup()    { /* Connect to test database, etc. */ }
func teardown() { /* Close connection, clean up if needed */ }

// Your test functions start here
