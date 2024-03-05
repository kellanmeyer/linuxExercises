#!/bin/bash
cat Property_Tax_Roll.csv | grep "MADISON SCHOOLS" | cut -d ',' -f 7 | {
    total=0
    count=0
    while read value; do
        total=$((total + value))
        count=$((count + 1))
    done
    sum=$(echo "$total")
    avg=$(echo "$total / $count" | bc -l)
    echo "Total: $sum"
    echo "Average: $avg"
}
