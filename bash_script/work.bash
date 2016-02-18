#!/bin/bash
stty intr %
OPTIONS="reboot eject_tape lock_account quit"
select opt in $OPTIONS; do
	if [ "$opt" = "quit" ]; then
		echo done
		exit
	elif [ "$opt" = "reboot" ]; then
		echo "normally, I would reboot here"
	elif [ "$opt" = "eject_tape" ]; then
		/usr/bin/eject /dev/tape
		echo "tape ejected"
	elif [ "$opt" = "lock_account" ]; then
		echo "please enter the troublesome user name"
		read LUSER
		echo "you entered $LUSER.  Are you sure? (y|n)"
		read SURE
		if [ $SURE == "y" ]; then
			/usr/bin/passwd -l $LUSER
			echo "locked $LUSER account"
			echo "account locked.  Call ops" | mail $LUSER
		fi
	else
		echo "bad option"
	fi
done
		
