#usage:
#bash summarize_counts.sh -f file -w window_width

while getopts f:w: flag
do
    case "${flag}" in
        f) f=${OPTARG};;
        w) w=${OPTARG};;
    esac
done

cat $f |\
awk -v w="$w" '{printf "%s_%4.0f,%s\n",$1,$2/w,$3'} |\
sed -E 's/_( ){1,3}/_/g' |\
awk -F ',' '
  NR == 0 { print; next }
  { a[$1] += $2 }
  END {
    for (i in a) {
      printf "%-15s\t%s\n", i, a[i];
    }
  }
'
