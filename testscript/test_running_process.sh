#!/bin/bash
cd "$(dirname "$0")"

status=$(curl -L -s --head -w %{http_code} https://uptime-app.azurewebsites.net -o /dev/null)
echo $status

if echo "$status" | grep -q 200
then
  # Send failed status to Uptime
  echo "Sending OK"
  status=$(curl -L -s --head -w %{http_code} https://uptime-app.azurewebsites.net/api/push/VpbyW98MKX\?msg=OK\&ping= -o /dev/null)
fi