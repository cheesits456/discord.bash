# discord.bash

An attempt at making a wrapper for Discord's HTTP API in bash

## Usage

First you'll need to set a bot token as the `TOKEN` variable in the `.env` file.

### Messages

#### Create

The `./messages/create.sh` script takes 2 arguments: a channel ID and the message content.

```bash
./messages/create.sh 719188046809006142 "testing 123"
```

#### Edit

The `./messages/edit.sh` script takes 3 arguments: a channel ID, a message ID, and the new message content.

```bash
./messages/edit.sh 719188046809006142 1080005282001862766 "testing 456"
```

#### Delete

The `./messages/delete.sh` script takes 2 arguments: a channel ID and a message ID.

```bash
./messages/delete.sh 719188046809006142 1080005282001862766
```
