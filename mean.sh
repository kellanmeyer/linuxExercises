#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <column> [file.csv]" 1>&2
  exit 1
fi


column="$1"


if [ "$#" -eq 2 ]; then
  file="$2"
else
  file="/dev/stdin"
fi


cut -d, -f"$column" "$file" | tail -n +2 | {
  sum=0
  count=0
  while IFS= read -r line; do
    sum=$(echo "$sum + $line" | bc)
    ((count++))
  done
  if [ $count -gt 0 ]; then
    mean=$(echo "scale=2; $sum / $count" | bc)
    echo $mean
  else
    echo "Error: No data to process" 1>&2
    exit 2
  fi
}
