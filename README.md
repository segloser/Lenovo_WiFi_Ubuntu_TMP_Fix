# Lenovo_WiFi_Ubuntu_TMP_Fix
A simple bash script to temporarily fix constant connection interruptions

If you are using a LENOVO G50 with a QCA6164 802.11ac Wireless Network Adapter, you are very likely suffering constant interruptions that avoid you to normally use your Internet, especially with Ubuntu 16.04.

After trying numerous fixes without no success, I preferred to solved the problem by myself until Ubuntu developers have the time to solve this fix permanently.

The script just send pings to Google DNS service in order to check the connection status. When no ICMP reply is received, the script initiates a WiFi connection. I have been trying this solution, and it is functional, so I will not invest much more time on this. Anyways, if you find smarter ways to do the same, let me know.


