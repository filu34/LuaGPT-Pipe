-- Załaduj bibliotekę LuaSocket
local http = require('socket.http')
local ltn12 = require('ltn12')

-- URL API ChatGPT
local url = 'https://api.openai.com/v1/engines/davinci-codex/completions'

-- Twoje dane uwierzytelniające do API
local headers = {
  ["Content-Type"] = "application/json",
  ["Authorization"] = "Bearer YOUR_OPENAI_API_KEY"
}

-- Dane wejściowe dla zapytania do API
local data = {
  prompt = "Translate the following English text to French: '{}'",
  max_tokens = 60
}

-- Zamień dane na format JSON
local json_data = require('json').encode(data)

-- Przygotuj zapytanie
local response = {}
local request_body, err = http.request{
  url = url,
  method = "POST",
  headers = headers,
  source = ltn12.source.string(json_data),
  sink = ltn12.sink.table(response)
}

-- Obsłuż błędy
if err then
  print('Wystąpił błąd: ', err)
else
  print(table.concat(response))
end
