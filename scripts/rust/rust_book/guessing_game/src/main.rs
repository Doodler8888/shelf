use rand::Rng;
use std::cmp::Ordering;
use std::io;

fn main() {
    println!("Guess the number!");
    let secret_number = rand::thread_rng().gen_range(1..=100);
    println!("The secret number is: {secret_number}");

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();
        io::stdin()
            .read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        println!("You guessed: {guess}");
        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You win!");
                break;
            }
        }
    }
}

// ::Rng is a trait, traits aren't directly accesible that why it's 'rand::thread_rng()' and not
// 'rand::Rng'.

// .read_line return a special enum called 'Result'. The enum has two potential states: 'Ok',
// 'Err'. It also has a method, if the returned value is 'Err', the method .expect will be called,
// which crashes a execution and prints out a string.

// For the guess variable, instead of using 'expect()', i use 'match' to gracefully handle an
// error. I'm able to use match becaues it works on enums, which parse returns.
// 'Ok' produces a computation (i gave it a 'num' name) of the variable declaration, which should
// be assighed back to the 'guess' variable. Because i use 'match' for error handling i have to
// write it like 'Ok(num) => num' instead of 'Ok => num' or something like this. So firstly i
// capture the computation 'Ok(num)' from which i create a variable '=> num,' that is assigned back
// to the 'guess'.
// The underscore, _, is a catch-all value; in this example, we’re saying we want to match all Err
// values, no matter what information they have inside them. So the program will execute the second
// arm’s code, continue, which tells the program to go to the next iteration of the loop and ask
// for another guess.

// 'let guess: u32' - once a varible is shadowed it's no longer accessible.
// But i still refer to it, when i create a shadowed variable - 'guess.trim()'.
// To compare a string to u32 we must eliminate all possible whitespaces, Also when i press 'Enter'
// it creates a newline. The '.trim()' method removes whitespaces and newlines.
// The parse method on strings converts a string to u32 type.

// 'break' makes the program to exit the loop. Exiting the loop also means exiting the program,
// because the loop is the last part of main.
