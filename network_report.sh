#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: Generate a report that gathers the systems current network configuration and statistics



# Variables
#--------------------------------------------------------------------------------------------------
# System Hostname
system_hostname=$(hostname)
# System Distribution
system_distribution=$(cat /etc/redhat-release)
# System Kernel Version
system_kernel_ver=$(uname -r)
# System Network Interface Card information, tr -s replaces all spaces with one blankspace character, ark with delimiter blankspace shows fields 1, 2, and 3
system_nics=$(ip -br addr | grep -v lo | tr -s ' ' | awk -F ' ' '{ print$1,$2,$3}')
# Network Interface Names
interfaces=$( nmcli con show | tail -n+2 | awk '{print $1}')

# Create the report file with the current date
REPORT="network.$(date +'%d-%m-%y').info.txt"

# Configure a root check to ensure non root users are unable to run the script, the local variable keeps the variable inside this function block only
chk_root() {
  local user_id=$(id -u)
  if [[ $user_id -ne 0 ]]; then
    echo -e "You must be the root user to run this tool"
    exit 999
  fi
}

# Configure a header for the report file
report_header() {
  echo -e "\n----------------------------------------"
  echo -e "Generating Network Report"
  echo -e "----------------------------------------\n"
}

# Configure information to dump into report using fuction
dump_info() {
  echo -e "Network Report For: $system_hostname" > $REPORT
  echo -e "----------------------------------------\n" >> $REPORT

  # System Information
  echo -e "System Distribution: $system_distribution\nCurrent Kernel Version: $system_kernel_ver\n" >> $REPORT

  # Network Interface Information
  for int in $interfaces; do
    echo -e "Interface Name: $int" >> $REPORT
    if [[ $(ethtool $int &> /dev/null;echo $?) -eq 0 ]]; then
      echo -e "Speed: $(ethtool $int | grep Speed:)\n"*********"" >> $REPORT
    else
      echo -e "Unable to retreive speed for: $int\n"**********"" >> $REPORT
    fi
  done
}


chk_root
report_header
dump_info
