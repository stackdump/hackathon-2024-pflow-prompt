curl -X POST \
    "https://api.langflow.astra.datastax.com/lf/832ceaf1-37c0-45bb-85ea-5ee73fcae7df/api/v1/run/be84ec55-d959-4b64-a6f9-0f1e46f34620?stream=false" \
    -H 'Content-Type: application/json'\
    -H "Authorization: Bearer ${DATA_STAX_KEY}"\
    -d '{"input_value": "build tic-tac-toe",
    "output_type": "chat",
    "input_type": "chat",
    "tweaks": {
  "ChatInput-wZB0Q": {},
  "OpenAIModel-O4WEP": {},
  "ChatOutput-Y8vpL": {},
  "TextInput-Vmm4H": {}
}}'
    
