#!/usr/bin/env bash

run_langflow() {
  local api_url="https://api.langflow.astra.datastax.com/lf/832ceaf1-37c0-45bb-85ea-5ee73fcae7df/api/v1/run/d286a33e-4be9-47f9-9a01-f6ef0c48687f?stream=false"
  local auth_token="${DATA_STAX_KEY_1}" # SET via ENV variable
  local input_value
  local response

  # Read input from stdin
  input_value=$1

  # Make the POST request and capture the response
  response=$(curl -s -X POST "$api_url" \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $auth_token" \
    -d '{
      "input_value": "'"${input_value}"'",
    "output_type": "chat",
    "input_type": "chat",
    "tweaks": {
    "ChatInput-tPBFS": {},
    "ChatOutput-nSNHa": {},
    "TextInput-SL8Sm": {},
    "OpenAIModel-aVavl": {}
      }
    }')

  # Extract the prompt using jq
  echo "$response" #| jq '.outputs[0].outputs[0].results.message.text | fromjson'
}

main() {
  local out=$(run_langflow $(cat))
  echo -e $out
}

main

# Example usage:# Example usage:
# echo "build tic-tac-toe" | ./stax.sh
