use clap::{Arg, Command};

fn main() {
    let matches = Command::new("echor")
        .version("0.1.0")
        .about("rust echo")
        .arg(
            Arg::new("text")
                .value_name("TEXT")
                .help("Prints out an input")
                .required(true)
                .num_args(1..),
        )
        .arg(
            Arg::new("omit_newline")
                .short('n')
                .help("Do not print newline"),
        )
        .get_matches();

    let text_values = matches.get_raw("text")
        .expect("Failed to get 'text'")
        .map(|os_str| os_str.to_string_lossy().into_owned())
        .collect::<Vec<String>>();
    let omit_newline = matches.contains_id("omit_newline");
    let ending = if omit_newline { "" } else { "\n" };
    print!("{}{}", text.join(" "), ending);
}

// .short('c')
// .long("config")
// .action(ArgAction::Set)

// println!("{:#?}", matches);
// "{:#?}" makes the print macro to output in a debug format.
// ':' - introduces format specifiers.
// '#' - # tells Rust to use the "alternate" form of printing. For many types, this means a more
// verbose or pretty-printed form.
// '?' - specifies that the value should be formatted using the Debug trait.

// get_raw("text") is a method call that attempts to retrieve all values associated with the
// argument named "text".
