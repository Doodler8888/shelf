// use clap::{Command, Arg};
// use clap::Command;
use clap;

fn main() {
    let _matches = Command::new("echor")
        .version("0.1.0")
        .about("rust echo")
        .arg(
            Arg::new("in_file")
                .short('c')
                .long("config")
                .action(ArgAction::Set)
                .value_name("FILE")
                .help("Provides a config file to myprog")
                .required(true),
        )
        .arg(
            Arg::with_name("omit_newline")
                .short("n")
                .help("Do not print newline")
                .takes_value(false),
        )
        .get_matches();
}
