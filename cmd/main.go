package main

import (
	"log"
	"os"
	"path/filepath"

	// tb "github.com/tucnak/telebot"
	tb "gopkg.in/telebot.v3"
)

func main() {
	var (
		port      = "8080"
		publicURL = "https://2722-178-121-35-10.ngrok-free.app" // you must add it to your config vars
		token     = os.Getenv("SHELF_TOKEN")      // you must add it to your config vars
	)

	webhook := &tb.Webhook{
		Listen:   ":" + port,
		Endpoint: &tb.WebhookEndpoint{PublicURL: publicURL},
	}

	pref := tb.Settings{
		Token:  token,
		Poller: webhook,
	}

	b, err := tb.NewBot(pref)
	if err != nil {
		log.Fatalln(err)
	}

	b.Handle("/start", func(c tb.Context) error {
		return c.Send("Hi!") 
	})

	b.Handle(tb.OnDocument, func(c tb.Context) error {
		file := c.Message().Document

		// Get the file extension
		ext := filepath.Ext(file.FileName)

		if ext == ".pdf" || ext == ".epub" {
			return c.Send("Book uploaded successfully!")
		} else {
			return c.Send("Invalid file format. Please upload a book file (PDF, EPUB, etc.).")
		}
	})

	b.Start()
}


// package main
//
// import (
// 	"log"
// 	"os"
//
// 	// tb "github.com/tucnak/telebot"
// 	tb "gopkg.in/telebot.v3"
// )
//
// func main() {
// 	var (
// 		port      = "8080"
// 		publicURL = "https://2722-178-121-35-10.ngrok-free.app" // you must add it to your config vars
// 		token     = os.Getenv("SHELF_TOKEN")      // you must add it to your config vars
// 	)
//
// 	webhook := &tb.Webhook{
// 		Listen:   ":" + port,
// 		Endpoint: &tb.WebhookEndpoint{PublicURL: publicURL},
// 	}
//
// 	pref := tb.Settings{
// 		Token:  token,
// 		Poller: webhook,
// 	}
//
// 	b, err := tb.NewBot(pref)
// 	if err != nil {
// 		log.Fatalln(err)
// 	}
//
// 	b.Handle("/start", func(c tb.Context) error {
// 		return c.Send("Hi!") 
// 	})
//
// 	b.Start()
// }