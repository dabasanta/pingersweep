#!/usr/bin/env bash

ipbase=$1

function usage(){
	echo -e "\n\n"
	echo "██████  ██ ███    ██  ██████  ███████ ██████  "
	echo "██   ██ ██ ████   ██ ██       ██      ██   ██ "
	echo "██████  ██ ██ ██  ██ ██   ███ █████   ██████  "
	echo "██      ██ ██  ██ ██ ██    ██ ██      ██   ██ "
	echo "██      ██ ██   ████  ██████  ███████ ██   ██ "
	echo "                          	                "
	echo "							"
	echo "PING SWEEP TOOL           			"
	echo "							"
	echo "Danilo Basanta (https://github.com/dabasanta/)	"
	echo "https://www.linkedin.com/in/danilobasanta/	"
	echo -e "\nProvide only the IP of the network to scan. This script automatically go across the IP addresses.\n"
	echo "Usage: $0 <IP>					"
	echo "Example: $0 192.168.1.0				"
	echo -e "\n\n"
}


function validateIP() {
	ipaddress=$1
	if [[ "$ipaddress" =~ ^(([0]?[0-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$ ]];then
		return 0
	else
		return 1
	fi
}

function pingSweep() {
	net=$(echo $1 | cut -d . -f 1-3)
	echo -e "\nStarting from $net.0\nPlease wait while ICMP request are sent...\n"
	for ip in $(seq 1 255);do
		tmp=$(ping -c 1 $net.$ip 2>/dev/null | grep 'bytes from' | cut -d ' ' -f 4 | cut -d ':' -f1)
		if [ -n "$tmp" ] ; then
			echo "[+] $tmp host UP!"
	    	else
			echo "$net.$ip down"
		fi
	done
}

if ! [ $# -eq 1 ] ; then
	usage
else
	if ! validateIP $ipbase;then
		exit 1
	else
		pingSweep $ipbase
	fi
fi
