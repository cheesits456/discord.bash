#!/bin/env bash
source ./.env
source ./config.sh

# Usage: ./channels/create.sh <guild_id> <channel_name>

curl	-X POST \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"name\": \"$2\"}" \
	https://discord.com/api/v"$api_version"/guilds/"$1"/channels
