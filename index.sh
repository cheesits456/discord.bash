#!/usr/bin/env bash

# Set variable for root directory path
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

# Source necessary scripts
source "$SCRIPT_DIR/.env"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/json-parse.sh"

# Source API functions
for file in "$SCRIPT_DIR"/*/*; do
	source "$file"
done

# Function to echo to stderr
errcho() { echo >&2 "$@"; }

# Function to print a pretty and useful error message
# args: $1 caller, $2 message
error_message() {
	function=$(caller | tac -s/ | head -n1 | awk -F. '{print $1}')
	errcho -e "\e[1;91mERR \e[96m$function\e[0m ($(
		echo -n "$1" | awk '{print $2}'
	):$(
		echo -n "$1" | awk '{print $1}'
	))\n\t$(
		echo -n "$2" | sed "s/\$[a-z0-9_]\+/\\\\e[1;93m&\\\\e[0m/gi"
	)"
}

# Helper function to generate a random file name
generate_filename() {
	for i in {1..8}; do
		printf "%x" $((RANDOM % 15))
	done
}

# Function to parse JSON data returned by API
parse_json() {
	filename=$(generate_filename)
	echo -n "$1" > "$filename"
	json-parse "$filename"
}