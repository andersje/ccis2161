#!/bin/bash
#this script will move to the center of the screen, regardless of
#terminal size.
clear

NUM_COLS=$(tput cols)
NUM_ROWS=$(tput lines)
MYSTRING="hi"
MYSTRING_LENGTH=2
let USEABLE=NUM_COLS-MYSTRING_LENGTH
let USEABLE_LINES=NUM_ROWS/2
let HALF=USEABLE/2
tput setaf 1
tput cup $USEABLE_LINES $HALF
echo $MYSTRING
