#!/bin/bash

# Script for alerts via email or SMS


# Edit these parameters:
# Email address
emailaddress=monitoring.nodes@gmail.com
#Phone number
phonenumber=+41763583958
# Textbelt key
textbeltkey=56fb1b493d99e6f2704c9b2809ffd643ad808d48BoMrjE6XaCBGhynmUanPyZFHf
# Delay between checks (E.g. 40s = 40 sec, 2m = 2 min, 1h = 1 hour)
check=30s
# Preset the email counter
emails=0
# Delay before re-sending the alert
alert=1m
iterations=3


for (( iteration=1; iteration<=$iterations; iteration++ )); do
        initial=`curl --insecure --connect-timeout 6 -s -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "icx_getLastblock", "id": 1234}' http://$ip/api/v3 | jq .result.height`
        if [ -z $initial ]; then
                continue
        fi
        sleep check;
        block=`curl --insecure --connect-timeout 6 -s -H 'Content-Type: application/json' -d '{"jsonrpc": "2.0", "method": "icx_getLastblock", "id": 1234}' http://$ip/api/v3 | jq .result.height`
        if [ -z $block ]; then
                continue
        else
                break
        fi
done

while [[ $emails -le 2 ]]
do
if [ -z $initial ]; then
        echo "Node is down!"
		curl -X POST https://textbelt.com/text --data-urlencode phone=''$phonenumber'' --data-urlencode message='ICON Testnet3 node is down!' -d key=$textbeltkey
		ssmtp $emailaddress < icntestnet.txt
else
        if [ -z $block ]; then
                echo "Node is down!"
				curl -X POST https://textbelt.com/text --data-urlencode phone=''$phonenumber'' --data-urlencode message='ICON Testnet3 node is down!' -d key=$textbeltkey
				ssmtp $emailaddress < icntestnet.txt
				else
                if [ "$initial" -eq "$block" ]; then
                        echo "Node is stop!"
                        curl -X POST https://textbelt.com/text --data-urlencode phone=''$phonenumber'' --data-urlencode message='ICON Testnet3 node is stop!' -d key=$textbeltkey
						ssmtp $emailaddress < icntestnet.txt
                fi
        fi
fi

sleep $alert
emails=$(($emails + 1))
done
