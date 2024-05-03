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


