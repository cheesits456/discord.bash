#!/usr/bin/env bash
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

source "$SCRIPT_DIR/.env"
source "$SCRIPT_DIR/config.sh"

for file in "$SCRIPT_DIR"/*/*; do
	source "$file"
done

errcho() { echo >&2 "$@"; }

# args: $1 caller, $2 message
error_message() {
	function=$(caller | tac -s/ | head -n1 | awk -F. '{print $1}')
	errcho -e "\e[1;91mERR \e[96m$function\e[0m ($(echo -n "$1" | awk '{print $2}'):$(echo -n "$1" | awk '{print $1}'))\n\t$2"
}
