#!/bin/bash
stty intr %
OPTIONS="cheese wine bread quit"
select opt in $OPTIONS; do
	if [ "$opt" = "quit" ]; then
		echo done
		exit
	elif [ "$opt" = "wine" ]; then
		let winecount+=1
		if [ $winecount -lt 5 ]; then
			echo "I recommend a Pinot Noir, they're quite popular these days"
		else
			echo "don't you think you've had enough?"
		fi
	elif [ "$opt" = "bread" ]; then
		echo "Perhaps a sourdough?"
	elif [ "$opt" = "cheese" ]; then
		echo "Cheddar is the most popular cheese in the world"
	else
		echo "bad option"
	fi
done
		
