#!/bin/env bash

# Usage: edit_channel <channel_id> <channel_name>

edit_channel() {
	curl -X PATCH \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"name\": \"$2\"}" \
	https://discord.com/api/v"$api_version"/channels/"$1"
}