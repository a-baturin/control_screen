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
                t=0
                s=6
                while [ $t -lt 11 ]
                do
                        t=$(( t + 1 ))
                        sleep 1
                        response=`fast-gpio read 18`
                        status=${response: -1}
                        if [[ "$status" -eq "1" ]]
                        then
                                t=0
                                s=$(( s - 1 ))
                                oled-exp cursor 1,0 write "Domoticz reload in "$s
                                if [ $s -lt 1 ]
                                then
                                        oled-exp cursor 1,0 write "Domoticz reload start"
                                        /etc/init.d/domoticz stop
                                        sleep 5
                                        mkdir -p /var/lib/domoticz/
                                        rm /var/lib/domoticz/*.db-shm
                                        rm /var/lib/domoticz/*.db-wal
                                        cp /root/domoticz-bkp/*.db /var/lib/domoticz/
                                        /etc/init.d/domoticz start
                                        oled-exp cursor 1,0 write "Domoticz reload end"
                                        sleep 3
                                        break
                                fi

                        fi
                done
                oled-exp power off
        fi
        sleep 1
done
