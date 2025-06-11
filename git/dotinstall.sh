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

# Function to install git files
git_install() {
    git config --global core.autocrlf input
    git config --global init.defaultBranch main
}

# Check if no options were provided, default action is to run git_install
if [ "$#" -eq 0 ]; then
    git_install
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

