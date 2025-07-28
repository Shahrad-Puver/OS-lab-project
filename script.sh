#!/bin/bash

# OS lab project
# by Shahrad-Puver (Shahrad Gazni)

# Capture the execution's start time
#start_time=$(date +%s)
start_time=$(date +%s%3N)

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

# Having a log file
log_file="$backup_path/backup.log"

# Create a temp directory to copy files into
temp_dir="$backup_path/backup_$timestamp"
mkdir -p "$temp_dir"

# Copy each file listed in backup.conf into the temp dir
while IFS= read -r file; do
	cp --parents "$file" "$temp_dir"
done < "$backup_path/backup.conf"

# Create a tar.gz archive of the backup
if tar -czf "$backup_path/backup_$timestamp.tar.gz" -C "$temp_dir" .; then
	result="[+] Success"
else
	result="[-] Failed"
fi

# Remove the temporary directory
rm -rf "$temp_dir"

# Calculating the size of the backup file
if [ -f "$backup_path/backup_$timestamp.tar.gz" ]; then
	size=$(du -h "$backup_path/backup_$timestamp.tar.gz" | cut -f1)
else
	size="0B"
fi

# Capture the end time of the execution
#end_time=$(date +%s)
end_time=$(date +%s%3N)
# Calculate the execution's time
duration=$((end_time - start_time))

# logging
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Backup: $result | Size: $size | Duration: ${duration}s" >> "$log_file"

#echo "$result in $duration seconds"
echo "$result in $duration ms"

