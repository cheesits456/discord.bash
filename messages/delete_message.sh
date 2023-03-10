#!/usr/bin/env bash

delete_message() {

	if [ -z "$channel" ]; then
		error_message "$(caller)" "\$channel variable is required"
		return
	fi
	if [ -z "$message" ]; then
		error_message "$(caller)" "\$message variable is required"
		return
	fi 

	data=$(
		curl 	--no-progress-meter \
			--request	"DELETE" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			https://discord.com/api/v"$api_version"/channels/"$channel"/messages/"$message" 2>&1
	)

	if [ "$1" == "clear" ]; then
		unset channel
		unset message
	fi
}