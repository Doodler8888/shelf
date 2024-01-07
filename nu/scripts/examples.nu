open /etc/passwd | lines | split column ':' | where { ($in.column3 | into int) >= 1000 } | get column1

# '$in' represents a line (the current item of a pipe) because i used 'lines'.
# And if i don't write '$in' before acessing column3 it will switch
# the current scope form the whole line to only the column3 and this is why 
# the value of the column1 is getting lost at the end.

# Curly brackets are used to create a scope. In the current example it will
# provides a new scope for each iteration of the 'where' command. If column3 isn't
# scoped, it will overshadowed by next iterations of the 'where' command.


# I had a csv file with data that looked like this.

# email,date
# me@example.com,Mon Jan 01 2024 15:59:34 GMT+0000
# you@this.com,Wed Nov 01 2023 23:20:09 GMT+0000
# And I needed to convert the date field into this:

# email,date
# me@example.com,2024-01-01
# you@this.com,2023-11-01

# open file.csv \
# | update date {|row| $row.date | into datetime | format date "%F"} \
# | save file2.csv
