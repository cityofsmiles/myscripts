#!/usr/bin/bash

mkdir clean

for f in *.csv; 
do 
  sed 's/\bMale\b/Boy/g;s/\bMALE\b/BOY/g' "$f" | tail -n+2 | cut --delimiter=, -f2,3,6,9 | sort --field-separator=',' -k4 -k2 -k3 > out-"$f" ;
  #sed 's/\bMale\b/Boy/g' "$f" | tail -n+2 | cut --delimiter=, -f2,3,6,9 | sort --field-separator=',' -k2 -k3 -k4 > out-"$f" ;
  #sed 's/\bMale\b/Boy/g' "$f" |  tail -n+2 | awk -F, '{print $6,$9,$2,$3}' OFS=, | sort --field-separator=',' -k4 -k1 -k2 > out-"$f" ;
  mv out-"$f" ./clean/"$f" ;
done;


