package database

import (
    // "context"
    "os"
    "database/sql"

    "github.com/uptrace/bun"
    "github.com/uptrace/bun/dialect/pgdialect"
    "github.com/uptrace/bun/driver/pgdriver"
)

type Book struct {
    bun.BaseModel `bun:"table:books,alias:b"` // The code within backticks called 'struct tag'.
    ID        int64  `bun:",pk,autoincrement"`
    Title     string `bun:",notnull"`
    Author    string 
    FilePath  string `bun:",nullzero"`
}

var db *bun.DB

func InitDB() { 
    // dsn := "host=" + os.Getenv("SHELF_DB_HOST") + " port=" + os.Getenv("DB_PORT") + 
    //         " user=" + os.Getenv("SHELF_DB_USER") + " password=" + os.Getenv("DB_PASS") + 
    //         " dbname=" + os.Getenv("SHELF_DB_NAME") + " sslmode=disable"

    dsn := "postgres://host=" + os.Getenv("SHELF_DB_HOST") + " port=" + os.Getenv("DB_PORT") + 
            " user=" + os.Getenv("SHELF_DB_USER") + " password=" + os.Getenv("DB_PASS") + 
            " dbname=" + os.Getenv("TEST_SHELF_DB_NAME") + " sslmode=disable"

    sqldb := sql.OpenDB(pgdriver.NewConnector(pgdriver.WithDSN(dsn))) 
    db = bun.NewDB(sqldb, pgdialect.New()) 

    // Optional: Test the connection
    // ctx := context.Background()
    if err := db.Ping(); err != nil {
        // Handle connection error
        panic(err) // For this example, panic if connection fails
    }
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
// Why 'Author' is Plain
//
// The  Author string  line has no Bun tags because you likely want to accept empty author fields in the database. By default, Go strings can already be NULL or empty, so no special tag is needed for Bun to handle this.
