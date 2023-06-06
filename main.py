import requests
import json

# API Settings
api_key = 'YOUR API KEY'
url = 'https://api.openai.com/v1/chat/completions'

# Function to send request to API
def send_completion_request(prompt):
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {api_key}'
    }
    data = {
        'prompt': prompt,
        'max_tokens': 100
    }
    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception(f'Request failed with status code {response.status_code}')

# Use Example
prompt = "Translate the following English text to French: 'Hello, how are you?'"
response = send_completion_request(prompt)
completion = response['choices'][0]['text']

print(completion)
