#!/bin/bash
case "$1" in 
	cheddar)
		echo "orange cheese"
		;;
	brie)
		echo "white cheese"
		;;
	mozzarella)
		echo "other white cheese"
		;;
	*)
		echo "I do not know the color of $1"
		;;
esac
