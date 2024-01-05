# let me = '<your-username>'

open --raw /etc/passwd | lines | split column ':' | get column3 | into int |
filter { |column3| $column3 >= 1000 } | select column1
# open --raw /etc/passwd | lines | split column ':' | get column3 | into int | where column3 > 1000
# open --raw /etc/passwd | lines | split column ':' | get column3 | into int |
# filter { |column3| $column3 >= 1000 }

# open /etc/passwd | lines | each { echo $it | split column ':' | get 0 | str } | where $it == $me
