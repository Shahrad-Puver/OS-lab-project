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
