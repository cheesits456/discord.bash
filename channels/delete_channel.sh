#!/usr/bin/env bash

delete_channel() {

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
		 	--request	"DELETE" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			https://discord.com/api/v"$api_version"/channels/"$channel" 2>&1
	)

	if [ "$1" == "clear" ]; then
		unset channel
	fi

	parse_json "$data"
}