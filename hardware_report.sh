#/bin/bash

# Author: Sphiffy
# Date: 4/29/24
# Description: Script that is used to report hardware metrics on the current system


# Variables

# Variable to fetch the CPU model using the /proc/cpuinfo file, awk to get first row, cut to show columns three and after
cpu_model=$(cat /proc/cpuinfo | grep -i "^model name" | awk 'NR==1' | tr -s ' ' | cut -d ' ' -f 3-)

# Variable to get current release
current_release=$(cat /etc/redhat-release)

# Variable to get current kernel version
kernel_version=$(uname -r)

# Variable to get system uptime uptime date and duration
sys_uptime=$(uptime -s)
sys_uptime_duration=$(uptime -p)

# Variable to get current partition information
partition_info=$(df -hTx tmpfs | grep -vi tmpfs)

# Variable to get fstab information
fstab_info=$(cat /etc/fstab | grep -v '^#' | tr -s ' ')

# Variable to get total number of processing currently running on the system
total_processes=$(ps -e | wc -l)
process_count=$(($total_processes - 1))

# Variable to display all block devices on the system
block_devices=$(lsblk -dn)


