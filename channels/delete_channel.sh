#!/bin/env bash

# Usage: delete_channel <channel_id>

delete_channel() {
	curl -X DELETE \
	-A "discord.bash ($repo, $version)" \
	-H "Authorization: Bot $TOKEN" \
	https://discord.com/api/v"$api_version"/channels/"$1"
}