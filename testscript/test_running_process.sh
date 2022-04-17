#!/bin/bash
cd "$(dirname "$0")"

status=$(curl -s --head -w %{http_code} https://uptime-app.azurewebsites.net -o /dev/null)
echo $status