#!/bin/env bash

# Usage: create_message <channel_id> <message_content>

create_message() {
	curl -X POST \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"content\": \"$2\"}" \
	https://discord.com/api/v"$api_version"/channels/"$1"/messages
}