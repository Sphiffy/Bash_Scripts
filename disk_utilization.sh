#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: Run through all the current disk partitions on the system and report any that exceed an 80% threshold


# Create a varaible that gets the list of all disk partitions on the system excluding any temporary filesystems
partitions=$(df -h | grep -v tmpfs | grep -v Filesystem | tr -s ' ' | awk -F ' ' '{print $1}')

# Command to get disk size: `df -h | grep /boot | tr -s ' ' | awk -F ' ' '{print $5}' | awk '{ print substr( $0, 1, length($0)-1 ) }'`
# Awk command used to remove last character from string, in this case used to remove the % sign `awk '{ print substr( $0, 1, length($0)-1 ) }'`
# Alternative to remove % sign with cut command`cut -d'%' -f1`

# Create a for loop that goes through each partition and checks if the disk size is greater than 80 percent utilization, the loop uses each partition, and the if statement checks if it's value is greater than or equal to 80
for x in $partitions; do
  if [[ $(df -h | grep $x | tr -s ' ' | awk -F ' ' '{print $5}' | awk '{ print substr( $0, 1, length($0)-1 ) }') -ge 80 ]]; then
    echo -e "Partition: $x has exceeded over 80% utilization, please check partition"
  fi
done

