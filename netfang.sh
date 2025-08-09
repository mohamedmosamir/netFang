#!/bin/bash

# =======================
# NetFang - WiFi Pentest Tool
# =======================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Animated Banner
clear
echo -e "${CYAN}"
echo "================================="
sleep 0.2
echo "        🐺  NetFang Tool         "
sleep 0.2
echo "     Advanced WiFi Pentest       "
sleep 0.2
echo "================================="
sleep 0.3
echo -e "${NC}"

while true; do
    echo -e "${YELLOW}Select an option:${NC}"
    echo -e "${CYAN}1)${NC} Start Monitor Mode"
    echo -e "${CYAN}2)${NC} Stop Monitor Mode"
    echo -e "${CYAN}3)${NC} Scan Networks"
    echo -e "${CYAN}4)${NC} Capture Packets"
    echo -e "${CYAN}5)${NC} Send Deauth Packets"
    echo -e "${CYAN}6)${NC} Crack WPA/WPA2 Password"
    echo -e "${CYAN}7)${NC} Test WPS Access (Reaver)"
    echo -e "${CYAN}8)${NC} Exit"
    echo ""
    read -p "Your choice: " choice

    case $choice in
        1)
            read -p "Enter interface name (e.g., wlan0): " iface
            sudo airmon-ng check kill
            sudo airmon-ng start $iface && echo -e "${GREEN}✅ Monitor mode enabled${NC}" || echo -e "${RED}❌ Failed to enable monitor mode${NC}"
            ;;
        2)
            read -p "Enter monitor mode interface (e.g., wlan0mon): " moniface
            sudo airmon-ng stop $moniface
            sudo service NetworkManager restart && echo -e "${GREEN}✅ Monitor mode disabled${NC}" || echo -e "${RED}❌ Failed to disable monitor mode${NC}"
            ;;
        3)
            read -p "Enter monitor mode interface (e.g., wlan0mon): " moniface
            sudo airodump-ng $moniface
            ;;
        4)
            read -p "Target BSSID: " bssid
            read -p "Channel (CH): " channel
            read -p "Output file name: " filename
            read -p "Monitor mode interface: " moniface
            sudo airodump-ng --bssid $bssid -c $channel -w $filename $moniface
            ;;
        5)
            read -p "Target BSSID: " bssid
            read -p "Number of deauth packets: " num
            read -p "Monitor mode interface: " moniface
            sudo aireplay-ng --deauth $num -a $bssid $moniface
            ;;
        6)
            read -p "Capture file name (e.g., capture.cap): " capfile
            read -p "Path to wordlist: " wordlist
            sudo aircrack-ng $capfile -w $wordlist
            ;;
        7)
            read -p "Target BSSID: " bssid
            read -p "Channel (CH): " channel
            read -p "Monitor mode interface: " moniface
            sudo reaver -i $moniface -b $bssid -c $channel -vv
            ;;
        8)
            echo -e "${CYAN}👋 Goodbye from NetFang!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}❌ Invalid choice!${NC}"
            ;;
    esac
done
