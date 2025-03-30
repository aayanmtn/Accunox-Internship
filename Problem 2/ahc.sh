#!/bin/bash
#Application Health Checker

URL="https://aayanmateen.tech"
STATUS=$(curl -o /dev/null -s -w "%{http_code}" $URL)

if [ "$STATUS" -eq 200 ]; then
  echo "Application is UP. Status Code: $STATUS"
else
  echo "Application is DOWN. Status Code: $STATUS"
fi
