#/bin/bash

ordbin() {
  a=$(printf '%d' "'$1")
  echo "obase=2; $a" | bc
}

ascii2bin() {
    echo -n $* | while IFS= read -r -n1 char
    do
        ordbin $char | tr -d '\n'
        echo " "
    done
}

read -p "Enter string to convert: " STRING_INPUT

ascii2bin $STRING_INPUT