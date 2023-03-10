#!/usr/bin/env bash

create_message() {

	if [ -z "$channel" ]; then
		error_message "$(caller)" "\$channel variable is required"
		return
	fi
	if [ -z "$content" ] && [ -z "$attachment" ]; then
		error_message "$(caller)" "At least one of the \$content or \$attachment variables is required"
		return
	fi 

	data=$(
		curl	--no-progress-meter \
		 	--request	"POST" \
			--user-agent	"discord.bash ($repo, $version)" \
			--header	"Authorization: Bot $TOKEN" \
			--form		"payload_json={\"content\":\"${content//\"/\\\"}\"}" \
			--form		"files[0]=$([ -z "$attachment" ] && echo -n "" || echo -n "@$attachment")" \
			https://discord.com/api/v"$api_version"/channels/"$channel"/messages 2>&1
	)

	if [ "$data" == "curl: (26) Failed to open/read local data from file/application" ]; then
		error_message "$(caller)" "File name provided in \$attachment variable is invalid"
	fi

	if [ "$1" == "clear" ]; then
		unset channel
		unset content
		unset attachment
	fi

	parse_json "$data"
}