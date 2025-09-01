#!/usr/bin/env bash

edit_channel() {

	type_int=0

	if [ -z "$channel" ]; then
		error_message "$(caller)" "\$channel variable is required"
		return
	fi
	if [ -z "$name" ] && [ -z "$topic" ]; then
		error_message "$(caller)" "At least one of the \$name or \$topic variables is required"
		return
	fi

	echo "{$(
				if [ -z "$name" ]; then
					echo -n ""
				else
					echo -n "\"name\":\"${name}\""
				fi
			)$(
				if [ -z "$name" ] || [ -z "$topic" ]; then
					echo -n ""
				else
					echo -n ","
				fi
			)$(
				if [ -z "$topic" ]; then
					echo -n ""
				else
					if [ "$topic" == "none" ]; then
						echo -n "\"topic\":\"\""
					else
						echo -n "\"topic\":\"${topic}\""
					fi
				fi
			)}"

	data=$(
		curl	--no-progress-meter \
		 	--request	"PATCH" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			--header	"Content-Type: application/json" \
			--data		"{$(
				if [ -z "$name" ]; then
					echo -n ""
				else
					echo -n "\"name\":\"${name}\""
				fi
			)$(
				if [ -z "$name" ] || [ -z "$topic" ]; then
					echo -n ""
				else
					echo -n ","
				fi
			)$(
				if [ -z "$topic" ]; then
					echo -n ""
				else
					if [ "$topic" == "none" ]; then
						echo -n "\"topic\":\"\""
					else
						echo -n "\"topic\":\"${topic}\""
					fi
				fi
			)}" \
			https://discord.com/api/v"$api_version"/channels/"$channel"
	)

	if [ "$1" == "clear" ]; then
		unset guild
		unset name
	fi

	parse_json "$data"

	if [ "$errors_topic__errors_0_code" == "CHANNEL_TOPIC_INVALID" ]; then
		error_message "$(caller)" "Channel topic is not compatible with this channel type"
	fi
}