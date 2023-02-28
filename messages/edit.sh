#!/bin/bash
source ./.env
source ./config.sh

# Usage: ./messages/edit.sh <channel_id> <message_id> <message_content>

curl	-X PATCH \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"content\": \"$3\"}" \
	https://discord.com/api/v"$api_version"/channels/"$1"/messages/"$2"
