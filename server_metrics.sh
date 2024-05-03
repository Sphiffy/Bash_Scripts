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

# Creating variable to gather total number of cpus and current load averages from uptime, use tr to translate all blankspaces to single blackspaces, use cut to remove all fields except 7 to the end using blankspace as the delimiter
num_cpu=$(lscpu | awk 'NR == 4' | tr -s ' ' | awk -F ' ' '{print $2}')
system_load=$(uptime | tr -s ' ' | cut -d ' ' -f 10-)

# Creating variable to gather current memeory utilization, using tr to make all blankspaces single blackspaces, using awk to get row 2 and field 2 and 7 for memory fields via the free command
total_mem=$(free -h | awk 'NR == 2' | tr -s ' ' | awk -F ' ' '{print $2}')
available_mem=$(free -h | awk 'NR == 2' | tr -s ' ' | awk -F ' ' '{print $7}')

# Creating variable to gather swap information, using tr to create single blankspace characters between fields, using awk to get swap fields via the free command
total_swap=$(free -h | awk 'NR == 3' | tr -s ' ' | awk -F ' ' '{print $2}')
used_swap=$(free -h | awk 'NR == 3' | tr -s ' ' | awk -F ' ' '{print $3}')

# Creating report
echo -e "System Uptime: $system_uptime"
echo -e "Total System CPUs: $num_cpu\nSystem Load: $system_load"
echo -e "Total System Memory: $total_mem\nAvailable System Memory: $available_mem"
echo -e "Total System Swap: $total_swap\nSystem Swap Used: $used_swap"
