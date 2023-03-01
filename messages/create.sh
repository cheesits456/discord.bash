#!/bin/env bash
source ./.env
source ./config.sh

# Usage: ./messages/create.sh <channel_id> <message_content>

curl	-X POST \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"content\": \"$2\"}" \
	https://discord.com/api/v"$api_version"/channels/"$1"/messages
