def main [...numbers] {

 mut total = 0
  
 for number in $numbers {
    $total += ($number | into int)
 }

 print $total

 # 2.
 print ($numbers | reduce { |it, acc| $it + $acc })

 # 3.
 print ($numbers | math sum)
}
