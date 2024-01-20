def --env main [file] {


 let latest_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | skip 1
 | each { split row ' ' | first | echo $in }
 | compact
 | each { cargo search $in | lines | first | split row ' ' | get 2 }

 let $current_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | parse --regex '\=\s*\"(?P<version>[^\"]+)\"' | values | flatten

 print "This are the current versions:" $current_dep_versions
 # $current_dep_versions | describe
 #
 # print "This are the latest versions:" $latest_dep_versions
 # $latest_dep_versions | describe
 #
 let version_map = $current_dep_versions | zip $latest_dep_versions | each { |pair| { current: $pair.0, latest: $pair.1 } } | flatten

 print $version_map



 # let new_file_content = open --raw $file
 # | lines
 # | each { $it | replace $version_map }
 #
 # print "New versions:" $new_file_content
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
