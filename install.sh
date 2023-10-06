#!/bin/bash

# Get the directory of the currently executing script
SCRIPT=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")/

# Function to display usage instructions
display_help() {
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  all   Execute all dotinstall.sh files in the script's directory and subdirectories."
    echo "  help  Display this help message."
}

# Function to execute dotinstall.sh files
run_dotinstall() {
    find "${SCRIPT}" -type f -name "dotinstall.sh" -exec bash {} \;
}

# Check if no options were provided, default action is to run dotinstall.sh files
if [ "$#" -eq 0 ]; then
    run_dotinstall
    exit 0
fi

# Handle options
while getopts ":h" opt; do
    case ${opt} in
        h) display_help ;;
        \?) echo "Invalid option: -${OPTARG}" >&2 ;;
    esac
done

# Check for valid arguments
if [ "$#" -gt 0 ]; then
    case $1 in
        all) run_dotinstall ;;
        help) display_help ;;
        *) echo "Unknown argument: $1. Use \"$0 help\" for usage instructions." ;;
    esac
fi

