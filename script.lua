request = syn and syn.request or http_request

local function get(url)
    return request({Url = url, Method = "GET"})
end

local function post(url, data)
    return request({Url = url, Method = "POST", Body = data}).Body
end

local function urlEncode(text)
    text = string.gsub (text, "\n", "\r")
    text = string.gsub (text, "([^%w ])",
        function (c) return string.format ("%%%02X", string.byte(c)) end)
    text = string.gsub (text, " ", "+")
    return text
end

local BASE_URL = "192.168.2.12:8080"

function addMessage(message)
    local res = get(BASE_URL .. "/add_message/"..message)
    print(res.StatusCode)
    consoleprint("Message sent to server 📤\n")
end
local text = "That night was so horrible."
addMessage(text)