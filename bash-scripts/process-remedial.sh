#!/usr/bin/bash

mkdir clean

for f in *.csv; 
do 
  #sed 's/\bMale\b/Boy/g' "$f" |  tail -n+2 | awk -F, '{print $9,$12,$2,$3,$6}' OFS=, | sort --field-separator=',' -k4 -k5 -k1 -k2 > out-"$f" ;
  sed 's/\bMale\b/Boy/g' "$f" |  tail -n+2 | awk -F, '{print $6,$9,$2,$12,$3}' OFS=, | sort --field-separator=',' -k4 -k5 -k1 -k2 > out-"$f" ;
  mv out-"$f" ./clean/"$f" ;
done;


