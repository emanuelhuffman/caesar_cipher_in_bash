#!/bin/bash

grade_update()
{
    # updates grade and prints based on return code of preceeding statement
    # usage: grade_update test_name points_to_add
    return_status=$?
    echo Test for: "$1" >>$student_file
    if (( return_status == 0 ))
    then
        echo "    passed and gives you "$2" more points" >>$student_file
        (( grade = grade + "$2" ))
    else
        echo "    failed and gives you 0 more points" >>$student_file
    fi
    echo >>$student_file
}


grade=0
student_file="results.txt"

echo -e "Tests follow, in recommended order of completion:\n" >$student_file

######## Tests -> ########

for filenum in {1..65}
do
    t0=$(date +%s.%N)
    echo -e "\n=============== Test file number / Caesar key $filenum ==============="
    timeout 30 bash bash-caesar.sh <test_in/encrypted-$filenum.txt >your_out/decrypted-$filenum.txt
    diff -y test_out/plaintext.txt your_out/decrypted-$filenum.txt
    grade_update "key/file $filenum crack worked" 1
    echo "Your program too the following number of seconds to run 1 file:"
    echo "print($(date +%s.%N) - $t0)" | python3
done

# bc didn't exist in container??
grade=$(echo "print(int($grade / 65 * 100))" | python3)

######## <- Tests ########

echo -e "Your grade is:\n$grade" >>$student_file

# cleanup
rm -rf __pycache__

cat $student_file

notdone=$(python3 -c "print($grade < 100)")
if [ $notdone == "True" ]
then
    echo -e "\nJust keep swimming..."
    exit 1
else
    echo -e "\nYou're almost done (now, verify your repo CI turns geen)!"
    exit 0
fi
