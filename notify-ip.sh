#!/bin/bash

IP_FILE="/tmp/last_ip.txt"

TO="$NOTIFY_EMAIL"
HOSTNAME="$SERVER_NAME"

CURRENT_IP=$(curl -s ifconfig.io)

if [ -f "$IP_FILE" ]; then
  LAST_IP=$(cat "$IP_FILE")
else
  LAST_IP=""
fi

if [ "$CURRENT_IP" != "$LAST_IP" ]; then
  echo -e "Subject: $HOSTNAME のグローバルIPが変更されました\n\n変更後のIP: $CURRENT_IP\n変更前のIP: $LAST_IP" \
  | ssmtp "$TO"

  echo "$CURRENT_IP" > "$IP_FILE"
fi
