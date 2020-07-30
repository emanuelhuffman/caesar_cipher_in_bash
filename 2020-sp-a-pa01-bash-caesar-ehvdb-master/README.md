# pa01 - Bash Caesar

![Hail Caesar...](huuugeCaesar.jpg)

* Your job on this assignment is to use the Python3 code from the book for the Caesar cracker while writing an almost identical program in bash.
* The source files to mimic or use for inspiration, include the Caesar hacker and the detecting English module from the book.
* We will use the exact same symbol set as the book code: 
    `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890 !?.`
* I have also included a `dictionary.txt` in this repo for you to use.
* This assignment should help you learn **both** Python3 and bash a bit better, and cover the basics of cracking cryptography.

## Deliverables
`bash-caesar.sh`

## How your program will be run
```sh
bash bash-caesar.sh <sample_cipher_text.txt >sample_decrypted_text.txt
```

## How you should test your program
Run this on your local machine:
```sh
./run_tests.sh
```
Actually read the contents of the tests in this file! 
This is the kind of testing you should be writing to test your code!

Then, once you are done, you can verify that you got all your code pushed by checking the CI build on git-classes.
You are not done until it's green!

## Notes
* **Please do not slam the git-classes server with this computationally intensive job needlessly, and only push when you need to sync or submit!**
* You CAN use the book code as guidance, just converting the algorithm there. 
  I do suggest changing/improving the detect English, perhaps to deal with low percentages.
* As always, this should be independent work!
* If you're going to copy elemental bash commands from the internet, make sure you UNDERSTAND them, and make sure it's not larger chunks of code!

## Due date
On Canvas.
