#!/bin/sh
echo '$0: Script Name: '$0
echo '$1: Keyword: '$1
echo "\nInput": $1
echo "\nOutput:"
curl=`cat <<EOS
curl --location --insecure --request POST 'https://api.openai.com/v1/chat/completions' \
--header 'Authorization: Bearer YOUR API KEY' \
--header 'Content-Type: application/json' \
--data-raw '{
 "model": "gpt-3.5-turbo",
 "messages": [{"role": "user", "content": "$1"}]
}' | jq '.choices[]'.message.content
EOS`
eval ${curl}
