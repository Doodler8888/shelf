def dolist [args?] {
 if $args == null {
   doctl projects list
 } else if $args == 'list' {
   doctl projects list | lines | first 1
 } else {
   doctl projects list --format $args
 }
}

# The question mark is used to show that the function can be used without a
# parameter. I can also write it like this: '[args?: string]'.

# cmd: 'if (ls -l (fd --type f --hidden . / | fzf) | get user | to text) == "root" {echo "first step"}'

def nvim_fzf [] {
  let fzf_item = (fd --type f --hidden . / | fzf)
  if (ls -l $fzf_item | get user | to text) == "root" {
    sudo -e $fzf_item
    } else {
    nvim $fzf_item
    }
  }

def bak [filename: string] {
 let name = (echo $filename | path basename)
 if (echo $name | str contains '.bak') {
 let new_name = $name | str replace '.bak' ''
 mv $filename $new_name
 } else {
 let new_name = $name + '.bak'
 mv $filename $new_name
 }
}

def gbs [] {
  let branch = (
    git branch |
    split row "\n" |
    str trim |
    where ($it !~ '\*') |
    where ($it != '') |
    str join (char nl) |
    fzf --no-multi
  )
  if $branch != '' {
    git switch $branch
  }
}

def gbd [] {
  let branches = (
    git branch |
    split row "\n" |
    str trim |
    where ($it !~ '\*') |
    where ($it != '') |
    str join (char nl) |
    fzf --multi |
    split row "\n" |
    where ($it != '')
  )
  if ($branches | length) > 0 {
    $branches | each { |branch| git branch -d $branch }
    ""
  }
}

# def fzf_zellij [] {
#   let session = zellij list-sessions 
#     | lines 
#     | split column -r '\s+' 
#     | get column1 
#     | to text 
#     | fzf --ansi 
#   if ($session | length) != "" {
#     zellij attach $session
#   }
# }

def fzf_zellij [] {
 let session = zellij list-sessions 
  | lines 
  | split column -r '\s+' 
  | get column1 
  | to text 
  | fzf --ansi 
 if $session == "" { # Initially i tried to do this 'if ($session | length) != "" {' without return, but it didn't solve the problems with "ambigious selection" input. Also, modifying it to use return also helped me to ...

  return
 }
 zellij attach $session
}

# ls | where name != 'd1' | each { mv $in.name "./d1" }
# open /etc/passwd | lines | split column : | where column3 == "1000" | get column1
# open /etc/passwd | lines | split column ':' | where { ($in.column3 | into int) >= 1000 } | get column1
