#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: This script is used to gather differennt system metrics from linux based hosts


# Creating variable to store system hostname
hostname=$(hostname)
echo -e "\nSystem Metrics for $hostname"
echo -e "------------------------------------------------------------\n"

# Creating variable to gather current uptime using awk to get only time related fields, awk again to remove ending comma from the string
system_uptime=$(uptime | awk -F ' ' ' {print $2,$3,$4}' | awk '$0=gensub(/^(.*),/,"\\1 ","g",$0)')
echo -e "System Uptime: $system_uptime"

# Creating variable to gather current load averages from uptime, use tr to translate all blankspaces to single blackspaces, use cut to remove all fields except 7 to the end using blankspace as the delimiter
system_load=$(uptime | tr -s ' ' | cut -d ' ' -f 7-)
echo -e "System Load: $system_load"

# Creating variable to gather current memeory utilization
total_mem=$(free -h | awk 'NR == 2' | tr -s ' ' | awk -F ' ' '{print $2}')
available_mem=$(free -h | awk 'NR == 2' | tr -s ' ' | awk -F ' ' '{print $7}')
echo -e "Total System Memory: $total_mem\nAvailable System Memory: $available_mem"
