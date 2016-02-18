#!/bin/bash
let RUN=0
while [ 1 == 1 ] ; do
	let RUN+=1
	BLACK="\033[0;30m"
	INV_GREEN="\033[7;32m"
	#clear
	tput cup 16 5
	echo -e "$INV_GREEN"
	who
	echo -e "$BLACK"
	echo "we've run $RUN times"
	sleep 5


done
