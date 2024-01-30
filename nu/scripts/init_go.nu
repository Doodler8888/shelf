let text = "\nThe module path is a unique identifier for your module. It's used to
import packages from your module in other Go programs. It can be a path to a
local or remote repository:

> go mod init my_project\n"

print -n "\nEnter path for the project:\n
1 - Enter a path
2 - Skip and move to the next stage\n\n"

input "=> " | match $in {
    "1" => { 
	print "\nEnter a path:\n" 
	let project_path = (input "=> ") | path expand
	mkdir $project_path
	}
    "2" => { print "You've pressed 2" }
     _ => { echo "Invalid choice" }
}

print $text

print "/nEnter module path:"
input "=> " | ^go mod init $in
