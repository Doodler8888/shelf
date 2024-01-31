def main [file] {


let latest_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | skip 1
 | each { split row ' ' | first | echo $in }
 | compact
 | each { cargo search $in | lines | first | split row ' ' | get 2 | str trim --char '"' }


let $current_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | parse -r '=\s*"([^"]+)"' | values | flatten

mut $index = 0
let $length = ($current_dep_versions | length)

while $index < $length {
  let $current_version = ($current_dep_versions | get $index)
  let $latest_version = ($latest_dep_versions | get $index)

  open --raw $file | str replace ($current_version) ($latest_version) | save -f $file

  $index = $index + 1
}

}


currentcurrent current
current currentcurrent 
