let me = '<your-username>'
open /etc/passwd | lines | each { echo $it | split column ':' | get 0 | str } | where $it == $me
