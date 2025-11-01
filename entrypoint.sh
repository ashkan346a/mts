#!/bin/bash
set -e

# Create user matching host UID/GID for mounts
if [ -n "$PUID" ] && [ "$PUID" != "0" ]; then
  deluser metasploit 2>/dev/null || true
  adduser -D -u $PUID -G metasploit metasploit
fi
if [ -n "$PGID" ] && [ "$PGID" != "0" ]; then
  addgroup -g $PGID metasploit 2>/dev/null || true
fi

# Switch to metasploit user
exec su-exec metasploit:$METASPLOIT_GROUP "$@"