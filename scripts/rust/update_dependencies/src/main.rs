use std::env;
use std::process::Command;
use toml_edit::{Document, value};
use regex::Regex;

fn main() {
    // Get the command-line arguments
    let args: Vec<String> = env::args().collect();

    // Check if the user provided the path as an argument
    if args.len() < 2 {
        eprintln!("Usage: cargo_update_deps <path_to_Cargo.toml>");
        std::process::exit(1);
    }

    // The first argument after the program name should be the path to the Cargo.toml file
    let cargo_toml_path = &args[1];

    // Rest of your code
    let mut cargo_toml_contents = std::fs::read_to_string(cargo_toml_path)
        .expect("Failed to read Cargo.toml");

    let mut doc = cargo_toml_contents.parse::<Document>().expect("Invalid TOML");

    let dependencies = doc["dependencies"].as_table_mut().unwrap();

    for (dep_name, _) in dependencies.iter() {
        let output = Command::new("cargo")
            .arg("search")
            .arg(dep_name)
            .output()
            .expect("Failed to run cargo search");

        let output_str = String::from_utf8_lossy(&output.stdout);

        let re = Regex::new(r#""([^"]+)" = "([^"]+)""#).unwrap();
        if let Some(caps) = re.captures(&output_str) {
            let latest_version = caps.get(2).unwrap().as_str();

            dependencies[dep_name] = value(latest_version);
        }
    }

    std::fs::write(cargo_toml_path, doc.to_string())
        .expect("Failed to write to Cargo.toml");
}
