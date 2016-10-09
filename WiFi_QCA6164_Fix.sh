#!/bin/bash
# Welcome screen
clear
echo
echo
echo

echo ".........................................."
echo ".    Welcome WiFi auto-reconnect tool    ."
echo ".........................................."
echo

# Initial instructions
# The user should know the name of the network s/he wants to connect
echo "Select the network you are connected to"
echo "======================================="
echo
# Creation of the list of available networks
nmcli d wifi list > /tmp/wifi_list.txt
# Extraction of the SSIDs from the previous list
cat /tmp/wifi_list.txt |sed 's/*/ /g'|grep -v SSID|awk '{print $1}' > /tmp/SSID.txt
# Setting the maximum number of avaiable networks
LIMIT=$(wc -l /tmp/SSID.txt |awk '{print $1}')
COUNTER=1;
# Removing any previous file in the tmp directory
rm /tmp/wifi_menu.txt
# Creating the available networks for the user with numbers to select more easily
touch /tmp/wifi_menu.txt
while [ $COUNTER -lt $LIMIT ]; do
	for LINE in $(cat /tmp/SSID.txt); do
		echo "# $COUNTER.- $LINE">> /tmp/wifi_menu.txt
	let COUNTER+=1;
	done;
done
cat /tmp/wifi_menu.txt
# Ask the user to input the number of the selected network
echo
echo "Type the number of your connection and press ENTER: "
read NET2CON
# Setting the variable SSID with the selected network
SSID=$(cat /tmp/wifi_menu.txt|grep "# $NET2CON.- "|awk '{print $3}')
# Second screen for the user, just before starting the auto-reconnection
clear
echo "Connecting to:"
echo "$SSID"
echo
echo
echo
echo "                      ***************************************************"
echo "                      * DO NOT CLOSE THIS WINDOW FOR AUTO-RECONNECT     *"
echo "                      * ===========================================     *"
echo "                      *  - Minimize the window and work normally        *"
echo "                      *  - If problems arise, just restart this program *"
echo "                      ***************************************************"

# Sending pings to Google
while true; do
	ping -c3 8.8.8.8 > /tmp/ping.txt
  # Sent ICMP packets
	A=$(cat /tmp/ping.txt |grep transmitted|awk '{print $1}')
  # Received ICMP packets
	B=$(cat /tmp/ping.txt |grep transmitted|awk '{print $4}')

	if [ $B == "0" ]; then
        	RESULT=0;
		C=$(date|awk '{print $4_$6}')
		mv /tmp/ping.txt /tmp/ping_$C.txt

	else
	        RESULT=1;
	fi
	while [ $RESULT == 0 ]; do
        nmcli c up $SSID;
	echo "Trying to reconnect..."
  # This tool needs a sleep period until the connection is established
  # Without this sleep time, an infinite loop would occur
	sleep 60;
	done

done
