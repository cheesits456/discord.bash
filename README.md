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