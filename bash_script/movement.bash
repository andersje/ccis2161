#!/bin/bash
clear
echo "lets move the cursor to the upper right hand corner"
echo "using tput cup 0 70"
tput cup 0 70
sleep 3
echo -e "\033[7;32mhello\033[0;30m"
sleep 2
tput cup 1 65
echo "lets go left"
sleep 2
tput cup 5 0
echo "now we're five lines down, at the left hand side"
echo "thanks to tput cup 5 0"

