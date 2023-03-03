#!/usr/bin/env bash

# Usage: create_channel <guild_id> <channel_name>

create_channel() {
	curl -X POST \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	-H "Content-Type: application/json"\
	-d "{\"name\": \"$2\"}" \
	https://discord.com/api/v"$api_version"/guilds/"$1"/channels
}