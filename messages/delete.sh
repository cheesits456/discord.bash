#!/bin/env bash

# Usage: delete_message <channel_id> <message_id>

delete_message() {
	curl -X DELETE \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	https://discord.com/api/v"$api_version"/channels/"$1"/messages/"$2"
}