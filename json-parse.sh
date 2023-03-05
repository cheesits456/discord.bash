#!/usr/bin/env bash
json-parse() {
	[ -z "$1" ] && exit 1
	input=$(cat "$1")
	output=""
	i=0
	line_break='
'
	exit=0
	var_name=()
	level=0
	in_value=false
	in_key=false
	in_array=false
	in_object=false
	after_key=false
	array_index=0
	keyname=""
	value=""
	last_char=""
	while [ $exit == "0" ]; do
		char=${input:i:1}
		case $char in
		"\"")
			if [ $in_key == true ]; then
				in_key=false
				var_name+=("$keyname")
				keyname=""
			elif [ $in_value == true ]; then
				if [ "$last_char" == "\\" ]; then
					value+="\\\""
				else
					in_value=false
					output+="$(
						IFS=_
						echo "${var_name[*]}"
					)=\"$value\"\n"
					value=""
				fi
			else
				if [ $after_key == false ]; then
					in_key=true
				else
					in_value=true
				fi
			fi
			;;
		":")
			if [ $in_key == false ] && [ $in_value == false ]; then
				if [ $after_key == false ]; then
					after_key=true
				fi
			elif [ $in_value == true ]; then
				value+="$char"
			fi
			;;
		"," | "}")
			if [ $in_key == false ] && [ $in_value == false ]; then
				if [ "$last_char" != "\"" ] && [ $after_key == true ]; then
					output+="$(
						IFS=_
						echo "${var_name[*]}"
					)=$value\n"
					value=""
				fi
				unset "var_name[-1]"
				if [ $in_array == true ] && [ $in_object == false ]; then
					after_key=true
					array_index=$((array_index + 1))
					var_name+=("$array_index")
				else
					after_key=false
				fi
				if [ "$char" == "}" ] && [ $in_array == true ]; then
					level=$((level - 1))
					if [ $level == 0 ]; then
						in_object=false
						after_key=true
					fi
				fi
			elif [ $in_value == true ]; then
				value+="$char"
			fi
			;;
		"{")
			if [ $in_key == false ] && [ $in_value == false ]; then
				if [ $after_key == true ]; then
					after_key=false
					in_object=true
					if [ $in_array == true ]; then
						level=$((level + 1))
					fi
				fi
			elif [ $in_value == true ]; then
				value+="$char"
			fi
			;;
		"[")
			if [ $in_key == false ] && [ $in_value == false ]; then
				if [ $after_key == true ]; then
					in_array=true
					var_name+=("$array_index")
				fi
			elif [ $in_value == true ]; then
				value+="$char"
			fi
			;;
		"]")
			if [ $in_key == false ] && [ $in_value == false ]; then
				if [ $after_key == true ]; then
					in_array=false
					after_key=false
					unset "var_name[-1]"
				fi
			elif [ $in_value == true ]; then
				value+="$char"
			fi
			;;
		*)
			if [ $in_key == true ]; then
				keyname+=$char
			elif [ $in_value == true ]; then
				value+=$char
			elif [ $after_key == true ] && [[ $char =~ [0-9aeflnrstu] ]]; then
				value+=$char
			fi
			;;
		esac
		if [ "$(echo -en "$char" | sed -E "s|\\S|match|g")" == "match" ]; then
			last_char=$char
		fi
		i=$(("$i" + 1))
		[ ${#input} == $i ] && exit=1
	done
	filtered_output=""
	IFS=$'\n'
	for line in ${output//\\n/$line_break}; do
		if [ "${line: -1}" != "=" ] && [ "${line: -4}" != "null" ]; then
			filtered_output+="${line//\\\\/\\}$line_break"
		fi
	done
	echo -n "$filtered_output" > "$1"
	source "$1"
	rm "$1"
}
