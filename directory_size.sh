#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: Reports directory statistics on specified directory from CLI


# Take input from the user running the script using the read command and -p for prompt
read -p 'Enter directory absolute path: ' dir_name

# If conditional statement to check if the user input matches an existing directoy, if so create a variable called dir_size that uses du to get its size and awk to print only the first column
if [[ -d $dir_name ]]; then
  dir_size=$(du -sh /home | awk '{print $1}')
  echo "The $dir_name is $dir_size"

# If the user input is not a directory but a file return the message that the input was not a directory
elif [[ -e $dir_name ]]; then
  echo "$dir_name is not a directory"

# If the user input was neither a file or directory return that it cannot find the inputed path
else
  echo "Unable to find $dir_name"
fi
