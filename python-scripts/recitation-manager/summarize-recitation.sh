#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

main_dir="$1"

results_dir="results"

cd $main_dir

mkdir -p $results_dir

consolidated_names="results1.txt"

recitation_results="recitation_results.txt"

cat *.txt > ./$results_dir/$consolidated_names

cd ./$results_dir

cp $consolidated_names temp.txt

sort -u +2 temp.txt > sorted.txt

echo -e "Number of Recitation for the Present Quarter \n" > $recitation_results
echo -e "Number of Recitation for the Present Quarter \n" > recitation_results.csv

while read p; do 
    num=$(grep "$p" $consolidated_names | wc -l)
    echo "$p = $num" >> $recitation_results
    echo "$p,$num" >> recitation_results.csv
done < sorted.txt

rm temp.txt sorted.txt $consolidated_names

