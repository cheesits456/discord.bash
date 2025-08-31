#!/usr/bin/env bash

create_channel() {

	if [ -z "$guild" ]; then
		error_message "$(caller)" "\$guild variable is required"
		return
	fi
	if [ -z "$name" ]; then
		error_message "$(caller)" "\$name variable is required"
		return
	fi

	data=$(
		curl	--no-progress-meter \
		 	--request	"POST" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			--header	"Content-Type: application/json" \
			--data		"{\"name\":\"${name}\"}" \
			https://discord.com/api/v"$api_version"/guilds/"$guild"/channels 2>&1
	)

	if [ "$1" == "clear" ]; then
		unset guild
		unset name
	fi

	parse_json "$data"
}