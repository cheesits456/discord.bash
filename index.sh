#!/bin/env bash
source ./.env
source ./config.sh

for file in ./*/*; do
	source "$file"
done

errcho() { >&2 echo "$@"; }