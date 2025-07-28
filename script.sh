#!/bin/bash

# OS lab project
# by Shahrad-Puver (Shahrad Gazni)

# Check for required arguments
# We require the user to give the script 3 arguments at the time of execution;
# If the number of received arguments is less than than, the script should abort.
if [ $# -ne 3 ]; then
	echo "Usage: $0 <source_path> <file_extension> <backup_path>"
	exit 1
fi

# Assigning the paths to variables:
src_path="$1"
extension="$2"
backup_path="$3"

# Checking if the given source path exists:
if [ ! -d "$src_path" ]; then
	echo "[!] Source path does not exist."
	exit 2
fi

# Check if the backup path exists
if [ ! -d "$backup_path" ]; then
	mkdir -p "$backup_path"
fi

# Find matching files and write full paths info backup.conf in the provided backup path
find "$src_path" -type f -name "*.$extension" > "$backup_path/backup.conf"

# Create a timestamp
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
echo "timestamp: $timestamp"
