#!/bin/bash

# Get the directory of the currently executing script
SCRIPT=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")/

# Function to display usage instructions
display_help() {
    echo "Usage: $0 [option]"
    echo
    echo "Options:"
    echo "  help  Display this help message."
}

# Function to install bashrc files
bashrc_install() {
    cat ${SCRIPT}bashrc_additions >> ~/.bashrc
}

# Check if no options were provided, default action is to run bashrc_install
if [ "$#" -eq 0 ]; then
    bashrc_install
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
        help) display_help ;;
        *) echo "Unknown argument: $1. Use \"$0 help\" for usage instructions." ;;
    esac
fi

