#!/bin/sh 

fast-gpio set-input 18
fast-gpio set-output 19
fast-gpio set 19 1

oled-exp -i
oled-exp dim on

while true 
do
	response=`fast-gpio read 18`
	status=${response: -1}
	if [[ "$status" -eq "1" ]]
	then
		oled-exp -c
		oled-exp cursor 0,0 write "IP: "`ifconfig | grep -A 1 apcli0 | grep -Eo "inet\ addr\:[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | grep -Eo "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"`
		oled-exp power on
		sleep 10
		oled-exp power off		
	fi
	sleep 1
done
