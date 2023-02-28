# discord.bash

An attempt at making a wrapper for Discord's HTTP API in bash

## Usage

First you'll need to set a bot token as the `TOKEN` variable in the `.env` file.

### Sending Messages

The `./send_message.sh` script takes 2 arguments: a channel ID and the message content.

```bash
./send_message.sh 719188046809006142 "testing 123"
```
