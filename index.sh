#!/bin/env bash
source ./.env
source ./config.sh

for dir in */; do
	for file in ./"$dir"*; do
		source "$file"
	done
done