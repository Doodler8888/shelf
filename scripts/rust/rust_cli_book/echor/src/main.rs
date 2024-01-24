use clap::{Command, Arg};

fn main() {
    let _matches = Command::new("echor")
        .version("0.1.0")
        // .author("wurkfreuz <wurfkreuz@gmail.com>")
        .about("Rust echo")
        .get_matches();
}
