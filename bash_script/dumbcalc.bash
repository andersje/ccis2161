#!/bin/bash
function add() {
	let total=$1+$2
	echo $total 
}

function subtract() {
	let total=$1-$2
	echo $total
}

function beclever() {
	echo "26"
	echo "Douglas Adams was wrong, you see."
}

function multiply() {
	if [[ $1 -eq 9 && $2 -eq 6 ]]; then
		beclever
	elif [[ $1 -eq 6 && $2 -eq 9 ]]; then
		beclever
	else
		let total=$1*$2
		echo $total
	fi
}

case "$1" in
	add)
		add $2 $3
		;;
	subtract)
		subtract $2 $3
		;;
	multiply)
		multiply $2 $3
		;;
	*)
		echo "I have no idea what to do"
		exit 1
		;;
esac

