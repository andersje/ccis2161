#!/bin/bash
# Copyright 2008 Jeremy Anderson.  This script distributed under
# the GPL.  Share your changes when you make them!  You can
# get the license terms from gnu.org

if [ "$1"x == "DEBUG"x ] ; then
	IPTABLES="echo /sbin/iptables"
elif [ "$1"x == "-vx" ] ; then
	echo "running in verbose mode"
	IPTABLES="/sbin/iptables -v"
else
	IPTABLES="/sbin/iptables"
fi
AWK="/usr/bin/awk"

function Sanitize() {
	if [ `$IPTABLES -L | egrep -c drop-and-log-it` -gt 0 ]; then
		$IPTABLES -F drop-and-log-it
	fi

	$IPTABLES -X
	$IPTABLES -Z
	#above clears all user-created chains and zeroes all counters	
	# this must be done AFTER all rules are flushed!
	return
}

function SetPolAndFlush() {
	CHAIN=$1
	POLICY=$2
	
	$IPTABLES -P $CHAIN $POLICY
	$IPTABLES -F $CHAIN

	return
}

function AllowInbound() {
	TARGETPORT=$1
	IP=$2
	PACKETTYPE=$3

	$IPTABLES -A INPUT -p $PACKETTYPE -d $IP --dport $TARGETPORT -j ACCEPT
	return;
}

function GetMyIP() {
	NIC=$1
	if [ "$NIC"x == "x" ]; then
		NIC="eth0"
	fi	
	MYIP=$(/sbin/ifconfig $NIC | $AWK -F "[ :]" '/inet addr:/{print $13}')
	echo $MYIP
}

function AllowEstablished() {
	$IPTABLES -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
	return
}

function IgnoreNuisancePacket() {
	TARGETPORT=$1
	PACKETTYPE=$2
	$IPTABLES -I INPUT -p $PACKETTYPE --dport $TARGETPORT -j DROP
	
	return
}

function LogUnknownProbes() {
	$IPTABLES -N drop-and-log-it
	
	$IPTABLES -A drop-and-log-it -j LOG --log-level warn 
	$IPTABLES -A drop-and-log-it -j DROP
	$IPTABLES -A INPUT -j drop-and-log-it
	return;
}

function IgnorePinhead() {
	IP=$1
	$IPTABLES -I INPUT -s $IP -j DROP
}

SetPolAndFlush INPUT DROP
SetPolAndFlush OUTPUT ACCEPT
SetPolAndFlush FORWARD DROP
Sanitize

$IPTABLES -I INPUT -i lo -j ACCEPT
AllowEstablished

MY_IP=$(GetMyIP)

for port in 22 80 8080 16500 143 1433; do
	AllowInbound $port $MY_IP tcp
done

for port in 21 109 111 135 136 137 139; do
	IgnoreNuisancePacket $port tcp
done

for WEINERHEAD in $(cat /etc/cracker); do
	IgnorePinhead $WEINERHEAD
done

LogUnknownProbes
