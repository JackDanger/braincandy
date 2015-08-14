#!/bin/bash

diff <(ruby answers.rb) <(python answers.py)
diff <(ruby answers.rb) <(javac Answers.java && java Answers)
diff <(ruby answers.rb) <(go run answers.go)
