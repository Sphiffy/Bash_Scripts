#!/bin/bash

# Author: Sphiffy
# Date: 4/29/2024
# Description: Takes user input for any file path and returns size and type information


# Ask user to input in the promt the aboslute path for a file and save it in the variable file_name
read -p "Enter the absolute path to the file or directory: " file_name

# Use an if statement to first check if the input exists, then use the stat command with awk to get the file type, [[ -e xxx ]] checks if xxx exists and if not exit the script
if [[ ! -e $file_name ]]; then
  echo "$file_name not found. Exiting"
  exit

# If the file exists create a variable called file_type and store the type from the stat command with string manipulation to get just the file type in the variable
else
  file_type=$(stat $file_name | awk -F ' ' 'NR==2' | tr -s ' ' | cut -d ' ' -f 9-)
fi

# Use a case statement to run through different code blocks depending on file type, display the file type and then the total size
case "$file_type" in
  "regular file")
    echo -e "$file_name is a $file_type\nSize: $(du -sh $file_name | awk -F ' ' '{print $1}')"
  ;;
  "directory")
    echo -e "$file_name is a $file_type\nSize: $(du -sh $file_name | awk -F ' ' '{print $1}')"
  ;;
  "character special file")
    echo -e "$file_name is a $file_type\nSize: $(du -sh $file_name | awk -F ' ' '{print $1}')"
  ;;
  "symbolic link")
    echo -e "$file_name is a $file_type\nSize: $(du -sh $file_name | awk -F ' ' '{print $1}')"
  ;;
  "block special file")
    echo -e "$file_name is a $file_type\nSize: $(du -sh $file_name | awk -F ' ' '{print $1}')"
  ;;
  *)
    echo "No available type in script"
  ;;
esac

# Testing a new line of comment code
