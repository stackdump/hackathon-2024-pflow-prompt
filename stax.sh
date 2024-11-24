#!/usr/bin/env bash

run_langflow() {
  local api_url="https://api.langflow.astra.datastax.com/lf/832ceaf1-37c0-45bb-85ea-5ee73fcae7df/api/v1/run/be84ec55-d959-4b64-a6f9-0f1e46f34620?stream=false"
  local auth_token="${DATA_STAX_KEY}" # SET via ENV variable
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
        "ChatInput-wZB0Q": {},
        "OpenAIModel-O4WEP": {},
        "ChatOutput-Y8vpL": {},
        "TextInput-Vmm4H": {}
      }
    }')

  # Extract the prompt using jq
  echo "$response" | jq '.outputs[0].outputs[0].results.message.text'
}

main() {
  run_langflow $(cat)
}

# Example usage:# Example usage:
# echo "build tic-tac-toe" | run_langflow
echo "build tic-tac-toe" | main

