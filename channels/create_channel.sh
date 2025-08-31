#!/usr/bin/env bash

create_channel() {

	type_int=0

	if [ -z "$guild" ]; then
		error_message "$(caller)" "\$guild variable is required"
		return
	fi
	if [ -z "$name" ]; then
		error_message "$(caller)" "\$name variable is required"
		return
	fi
	if [ -z "$type" ]; then
		type="text"
	fi

	case "$type" in
		"category") type_int=4  ;;
		"forum")    type_int=15 ;;
		"text")     type_int=0  ;;
		"voice")    type_int=2  ;;
	esac

	data=$(
		curl	--no-progress-meter \
		 	--request	"POST" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			--header	"Content-Type: application/json" \
			--data		"{\"name\":\"${name}\",\"type\":${type_int},\"topic\":\"${topic}\"}" \
			https://discord.com/api/v"$api_version"/guilds/"$guild"/channels
	)

	if [ "$1" == "clear" ]; then
		unset guild
		unset name
		unset topic
		unset type
	fi

	parse_json "$data"

	if [ "$errors_topic__errors_0_code" == "CHANNEL_TOPIC_INVALID" ]; then
		error_message "$(caller)" "Channel topic is not compatible with this channel type"
	fi
}