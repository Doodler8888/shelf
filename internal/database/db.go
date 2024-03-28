package database

import (
	// "context"
	"database/sql"
	"fmt"
	"os"
	"time"

	"github.com/uptrace/bun"
	"github.com/uptrace/bun/dialect/pgdialect"
	"github.com/uptrace/bun/driver/pgdriver"
)

type Book struct {
	bun.BaseModel `bun:"table:books,alias:b"` // The code within backticks called 'struct tag'.
	ID            int64                       `bun:",pk,autoincrement"`
	Title         string                      `bun:",notnull"`
	Author        string                      `bun:",null"`
	FilePath      string                      `bun:",nullzero"`
	UploadedAt    time.Time                   `bun:",notnull"`
}

var db *bun.DB

func InitDB() {
	host := os.Getenv("SHELF_DB_HOST")
	port := os.Getenv("SHELF_DB_PORT")
	user := os.Getenv("SHELF_DB_USER")
	password := os.Getenv("SHELF_DB_PASS")
	// dbname := os.Getenv("SHELF_DB_NAME")
	dbname := os.Getenv("TEST_SHELF_DB_NAME")

	// Correctly format the DSN string
	dsn := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable", user, password, host, port, dbname)

	sqldb := sql.OpenDB(pgdriver.NewConnector(pgdriver.WithDSN(dsn)))
	db = bun.NewDB(sqldb, pgdialect.New())

	// Optional: Test the connection
	// ctx := context.Background()
	if err := db.Ping(); err != nil {
		fmt.Println("Database connection successful.")
		panic(err)
	}
	fmt.Println("Database connection successful.")
}

// bun.BaseModel `bun:"table:books,alias:b"`
//
// bun.BaseModel: Embedding this type gives your Book struct Bun's core database interaction capabilities.
// "table:books,alias:b":
// table:books - Tells Bun to link this struct to the 'books' table in your database.
// alias:b - Creates an alias 'b' for the table, allowing terser queries.
// ID int64bun:",pk,autoincrement"`
//
// ",pk": Marks the ID field as the primary key of the table.
// ",autoincrement": Instructs Bun to handle auto-incrementing the ID value during insertion.
// Title stringbun:",notnull"`
//
// ",notnull": Enforces that the 'Title' column cannot be null in the database.
// FilePath stringbun:",nullzero"`
//
// ",nullzero": Allows the ‘FilePath’ column to store NULL in the database. If no file path is provided, Bun will handle inserting a zero value for the string conveniently.
//
// The  Author string  line has no Bun tags because you likely want to accept empty author fields in the database. By default, Go strings can already be NULL or empty, so no special tag is needed for Bun to handle this.

// Why Use nullzero on FilePath but not on Author?
// An empty string ("")  could be a potentially valid filepath in certain
// scenarios. So not using nullzero could lead to an unintended empty filepath
// stored in the database.
