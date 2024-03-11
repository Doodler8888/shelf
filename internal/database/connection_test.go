package database

import (
    "fmt"
    "os"
    "testing"
    "context"
)

func TestMain(m *testing.M) {
    // Setup: Call your database initialization
    InitDB() 

    // Run tests
    exitCode := m.Run()

    // Teardown (optional): You might want to close DB connections or clean up

    os.Exit(exitCode)
}

func TestDBConnection(t *testing.T) {
    // Simple query to verify connectivity
    _, err := db.NewSelect().Model((*Book)(nil)).Exec(context.Background())
    if err != nil {
        t.Errorf("Error pinging the database: %v", err)
    } else {
        fmt.Println("Database connection successful.")
    }
}


// m is a pointer to a struct of type testing.M.
// This struct gives you access to a method called Run(), which is responsible
// for actually executing your test functions.

// t is a pointer to a struct of type testing.T.
// It provides methods like:
// Errorf to signal test errors.
// FailNow to immediately abort the current test.
// Helper methods for assertions.

