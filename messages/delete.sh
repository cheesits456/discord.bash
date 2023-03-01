#!/bin/env bash
source ./.env
source ./config.sh

# Usage: ./messages/delete.sh <channel_id> <message_id>

curl	-X DELETE \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	https://discord.com/api/v"$api_version"/channels/"$1"/messages/"$2"
