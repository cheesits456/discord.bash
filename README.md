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

### Messages

#### Create

The `create_message` function depends on the `$channel` variable and at least one of the `$content` or `$attachment` variables, where:

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

#### Edit

The `edit_message` function takes 3 arguments: a channel ID, a message ID, and the new message content.

```bash
edit_message 719188046809006142 1080005282001862766 "testing 456"
```

#### Delete

The `delete_message` function takes 2 arguments: a channel ID and a message ID.

```bash
delete_message 719188046809006142 1080005282001862766
```

### Channels

#### Create

The `create_channel` function takes 2 arguments: a guild ID and the channel name.

```bash
create_channel 444523238580813825 "testing-channel"
```

#### Edit

The `edit_channel` function takes 2 arguments: a channel ID and the new channel name.

```bash
edit_channel 1080391136033636362 "testing-123"
```

#### Delete

The `delete_channel` function takes 1 argument: a channel ID.

```bash
delete_channel 1080391136033636362
```
