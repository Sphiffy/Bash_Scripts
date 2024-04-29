#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: Generate a report that gathers the systems current network configuration and statistics


# Variables
system_hostname=$(hostname)


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
  echo -e "----------------------------------"
  echo -e "Generating Network Report"
  echo -e "----------------------------------"
}

# Configure information to dump into report

dump_info() {
  echo -e "Network Report For: $system_hostname\n" > $REPORT
}


chk_root
report_header
dump_info
