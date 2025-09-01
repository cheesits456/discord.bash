# discord.bash

An attempt at making a wrapper for Discord's HTTP API in bash

## Usage

First you'll need to set a bot token as the `TOKEN` variable in the `.env` file. In your script you'll need to `source` the `index.sh` file to gain access to the functions. A basic example to send a message to a channel would be like this:

```bash
#!/usr/bin/env bash
source ./index.sh
channel="719188046809006142"
content="This is a message sent from bash"
send_message
```

Every function takes an optional `clear` argument that unsets every variable used by the function, for example:

```bash
channel="719188046809006142"
content="This is a message sent from bash"
send_message "clear"
echo "$channel" # this will print a blank line
```

After a function is called, it'll parse the JSON data returned by the API into variables that you can use. When parsed, any values that are `null` or empty arrays will be ignored. Nested object keys will be combined with an underscore, and in an array the array index will be added with an underscore. An example of JSON data returned from the API is

```json
{
	"id": "1081056853196296292",
	"type": 0,
	"content": "1\" 2: 3, 4} 5{ 6[ 7]",
	"channel_id": "719188046809006142",
	"author": {
		"id": "739697358350057503",
		"username": "SSH Bot",
		"display_name": null,
		"avatar": "fac5be6015240610d44ab269f49727d0",
		"avatar_decoration": null,
		"discriminator": "2953",
		"public_flags": 0,
		"bot": true
	},
	"attachments": [
		{
			"id": "1081056852961406986",
			"filename": "text.txt",
			"size": 121,
			"url": "https://cdn.discordapp.com/attachments/719188046809006142/1081056852961406987/text.txt",
			"proxy_url": "https://media.discordapp.net/attachments/719188046809006142/1081056852961406987/text.txt",
			"content_type": "text/plain; charset=utf-8"
		}
	],
	"embeds": [],
	"mentions": [],
	"mention_roles": [],
	"pinned": false,
	"mention_everyone": false,
	"tts": false,
	"timestamp": "2023-03-03T03:33:58.867000+00:00",
	"edited_timestamp": null,
	"flags": 0,
	"components": [],
	"referenced_message": null
}
```

The corresponding variables this will be parsed into are

```bash
id="1081056853196296292"
type=0
content="1\" 2: 3, 4} 5{ 6[ 7]"
channel_id="719188046809006142"
author_id="739697358350057503"
author_username="SSH Bot"
author_avatar="fac5be6015240610d44ab269f49727d0"
author_discriminator="2953"
author_public_flags=0
author_bot=true
attachments_0_id="1081056852961406986"
attachments_0_filename="text.txt"
attachments_0_size=121
attachments_0_url="https://cdn.discordapp.com/attachments/719188046809006142/1081056852961406987/text.txt"
attachments_0_proxy_url="https://media.discordapp.net/attachments/719188046809006142/1081056852961406987/text.txt"
attachments_0_content_type="text/plain; charset=utf-8"
pinned=false
mention_everyone=false
tts=false
timestamp="2023-03-03T03:33:58.867000+00:00"
flags=0
```

While coding it can be useful to see the data returned by the API so you know what the variable names are. To print out the parsed JSON data after executing a function, set a varable called `verbose` to `true` as in the following example:

```bash
#!/usr/bin/env bash
source ./index.sh
channel="719188046809006142"
content="This is a message sent from bash"
verbose=true
send_message
```

> [!IMPORTANT]  
> The `verbose` variable will unset itself after each function call, so if you want multiple functions to print out their variables, you'll need to set the `verbose` variable to `true` before each function call

## Messages

### Create

The `create_message` function depends on the `$channel` and at least one of the `$content` or `$attachment` variables, where:

- `$channel` is a channel ID
- `$content` is the desired message content
- `$attachment` is a path to a file

Example:

```bash
channel="719188046809006142"
content="testing 123"
attachment="/path/to/file.txt"
create_message
```

### Edit

The `edit_message` function depends on the `$channel`, `$message`, and at least one of the `$content` or `$attachment` variables, where:

- `$channel` is a channel ID
- `$message` is the ID of the message to edit
- `$content` is the desired message content
- `$attachment` is a path to a file

Example:

```bash
channel="719188046809006142"
message="1083634354493849660"
content="testing 456"
attachment="/path/to/another-file.txt"
edit_message
```

### Delete

The `delete_message` function depends on the `$channel` and `$message` variables, where:

- `$channel` is a channel ID
- `$message` is the ID of the message to delete

Example:

```bash
channel="719188046809006142"
message="1083634354493849660"
delete_message
```

## Channels

### Create

The `create_channel` function depends on the `$guild` and `$name` variables with optional `$topic` and `$type` variables, where:

- `$guild` is a server ID
- `$name` is the desired channel name
- `$topic` is the desired channel topic (for forum channels this variable will be used for the post guidelines)
- `$type` is the desired channel type, which can be one of the following:
	- `category`
	- `forum`
	- `text` (default if not specified)
	- `voice`

```bash
guild="444523238580813825"
name="new-channel"
topic="channel topic"
type="text"
create_channel
```

### Edit

The `edit_channel` function depends on the `$channel` and at least one of the `$name` or `$topic` variables, where:

- `$channel` is a channel ID
- `$name` is the desired channel name
- `$topic` is the desired channel topic (set to `none` to remove the channel's topic)

```bash
channel="719188046809006142"
name="new-name"
topic="new topic"
edit_channel
```

### Delete

The `delete_channel` function depends on the `$channel` variable, where:

- `$channel` is a channel ID

```bash
channel="719188046809006142"
delete_channel
```