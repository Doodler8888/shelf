def --env main [file] {


 # let latest_dep_versions = open --raw $file
 # | lines
 # | skip until { |it| $it == '[dependencies]' }
 # | skip 1
 # | each { split row ' ' | first | echo $in }
 # | compact
 # | each { cargo search $in | lines | first | split row ' ' | get 2 | compact }
 # print "Latest versions:" $latest_dep_versions

 let new_file_content = open --raw $file
 $new_file_content
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | parse --regex '\=\s*\"(?P<version>[^\"]+)\"'
 # | default version ""
 # | each { |it| $it.version }

 # | parse --regex '= \"(?P<version>[^\"]+)\"'

}


# def --env main [file] {
#
#
#  let file_content = open --raw $file
#
#  $file_content
#  | lines
#  | skip until { |it| $it == '[dependencies]' }
#  | skip 1
#  | each { split row ' ' | first | echo $in }
#  | compact
#  | each { cargo search $in | lines | first | split row ' ' | get 2 }
#  | to text
#
#
#  let new_file_content = open --raw $file
#
#  $new_file_content
#  | lines
#  | skip until { |it| $it == '[dependencies]' }
#  | skip 1
#  | parse --regex '=\\s*"(?P<version>[^"]+)"'
#  | get version
# }
#
