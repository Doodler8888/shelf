def --env main [file] {


let latest_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | skip 1
 | each { split row ' ' | first | echo $in }
 | compact
 | each { cargo search $in | lines | first | split row ' ' | get 2 | str trim --char '"' }

# print "Latest versions:" $latest_dep_versions

let $current_dep_versions = open --raw $file
 | lines
 | skip until { |it| $it == '[dependencies]' }
 | parse --regex '\=\s*\"(?P<version>[^\"]+)\"' | values | flatten

# print "Current versions:" $current_dep_versions

let version_map = $current_dep_versions 
 | zip $latest_dep_versions 
 | each { |pair| { current: $pair.0, latest: $pair.1 } } 
 | flatten

let content = open --raw $file | lines

# let updated_content = $content | each { |line|
#    let line_replaced = $version_map | each { |version|
#      let cur = $version.current
#      let lat = $version.latest
#      if ($line | str contains $cur) {
#        $line | update $cur $lat
#      } else {
#        $line
#      }
# }
# }
#
# print $updated_content
#
# let updated_content = $content | each { |line|
#    let line_replaced = $version_map | each { |version|
#      let cur = $version.current
#      let lat = $version.latest
#      if ($line | str contains $cur) {
#        $line | str replace $cur $lat
#      } else {
#        $line
#      }
#    }
#    $line_replaced | get 0
# }
#
# print $updated_content

print "This is a version map:" $version_map

# let updated_content = $content | each { |line|
#   mut line_replaced = $line
#   $version_map | each { |version|
#     let cur = $version.current
#     let lat = $version.latest
#     if ($line | str contains $cur) {
#       line_replaced = ($line | str replace $cur $lat )
#     }
#   }
# }

let updated_content = $content | each { |line|
 mut line_replaced = $line
 $version_map | each { |version|
    let cur = $version."current"
    let lat = $version."latest"
    if ($line | str contains $cur) {
      line_replaced = ($line | str replace $cur $lat )
    }
 }
}


print $updated_content

# $updated_content | save --force $file


# print $updated_content

}

