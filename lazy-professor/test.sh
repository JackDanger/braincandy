#!/bin/bash

run(){
  case $1 in
    'python')
      python answers.py
      ;;
    'ruby')
      ruby answers.rb
      ;;
    'clojure')
      lein repl <<< '(load-file "answers.clj")' | grep output | cut -d ' ' -f 2
      ;;
    'java')
      javac Answers.java
      java Answers
      ;;
    'go')
      go run answers.go
      ;;
    'zsh')
      ./answers.zsh
      ;;
  esac
}

ruby_out=$(run ruby)
python_out=$(run python)
java_out=$(run java)
go_out=$(run go)
clojure_out=$(run clojure)
zsh_out=$(run zsh)

diff <(echo $ruby_out) <(echo $python_out)  && echo "Python: OK"
diff <(echo $ruby_out) <(echo $java_out)    && echo "Java: OK"
diff <(echo $ruby_out) <(echo $go_out)      && echo "Go: OK"
diff <(echo $ruby_out) <(echo $clojure_out) && echo "Clojure: OK"
diff <(echo $ruby_out) <(echo $zsh_out)     && echo "ZSH: OK"
