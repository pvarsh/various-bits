#!/bin/bash
# Place this file, your assignment_2.py file, and sample_data_problem_#.txt files into the same directory
# Navigate to directory containing the above in terminal and type
# bash test_script.sh
#
# If your output is exactly identical to the sample output, the script will print
# comparing 1
# comparing 2
# comparing 3
# comparing 4
# comparing 5
# comparing 6
#
# For example if your output for problem 3 is different (notice LAW and lAW in Agency field), it will print something like
# comparing 1
# comparing 2
# comparing 3
# 4c4
# < 5|LAW DEPARTMENT|1|Assessor|ASSESSOR|40623|100000|Annual|Queens|Tax|supervision|baccalaureate|elibigible| |11/26/2013 00:00:00
# ---
# > 5|lAW DEPARTMENT|1|Assessor|ASSESSOR|40623|100000|Annual|Queens|Tax|supervision|baccalaureate|elibigible| |11/26/2013 00:00:00
# comparing 4
# comparing 5
# comparing 6

for i in `seq 1 6`; do
    python assignment_2.py sample_data_problem_$i.txt > output_problem_$i.txt
    echo "comparing" $i
    diff sample_output_problem_$i.txt output_problem_$i.txt  
done
