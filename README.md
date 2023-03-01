# discord.bash

An attempt at making a wrapper for Discord's HTTP API in bash

## Usage

First you'll need to set a bot token as the `TOKEN` variable in the `.env` file. In your script you'll need to `source` the `index.sh` file to gain access to the functions. A basic example to send a message to a channel would be like this:

```bash
#!/bin/env bash
source ./index.sh
create_message 719188046809006142 "This is a message sent from bash"
```

### Messages

#### Create

The `create_message` function takes 2 arguments: a channel ID and the message content.

```bash
create_message 719188046809006142 "testing 123"
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