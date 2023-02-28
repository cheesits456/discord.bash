# discord.bash

An attempt at making a wrapper for Discord's HTTP API in bash

## Usage

First you'll need to set a bot token as the `TOKEN` variable in the `.env` file.

### Sending Messages

The `./send_message.sh` script takes 2 arguments: a channel ID and the message content.

```bash
./send_message.sh 719188046809006142 "testing 123"
```

### Editing Messages

The `./edit_message.sh` script takes 3 arguments: a channel ID, a message ID, and the new message content.

```bash
./edit_message.sh 719188046809006142 1080005282001862766 "testing 456"
```

### Deleting Messages

The `./delete_message.sh` script takes 2 arguments: a channel ID and a message ID.

```bash
./delete_message.sh 719188046809006142 1080005282001862766
```
