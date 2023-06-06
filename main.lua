local http = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local json = require("cjson")

local function send_completion_request(keyword)
    local url = "https://api.openai.com/v1/chat/completions"
    local api_key = "YOUR API KEY"
    local headers = {
        ["Authorization"] = "Bearer " .. api_key,
        ["Content-Type"] = "application/json"
    }
    local data = {
        model = "gpt-3.5-turbo",
        messages = {
            {role = "user", content = keyword}
        }
    }
    local response_body = {}

    local res, code, response_headers = http.request{
        url = url,
        method = "POST",
        headers = headers,
        source = ltn12.source.string(json.encode(data)),
        sink = ltn12.sink.table(response_body)
    }

    if code == 200 then
        local response_json = table.concat(response_body)
        local response = json.decode(response_json)
        for _, choice in ipairs(response.choices) do
            print(choice.message.content)
        end
    else
        error("Request failed with status code " .. code)
    end
end

-- Use example
local keyword = "Hi there, from Lua API handler!"
send_completion_request(keyword)

