request = syn and syn.request or http_request
local HttpService = game:GetService("HttpService")

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

local BASE_URL = "http://192.168.2.12:8080"

function addMessage(message)
    local res = get(BASE_URL .. "/add_message/"..HttpService:UrlEncode(message))
    print(res.StatusCode)
    print("Message sent to server 📤")
end

local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
print("Go")
ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(obj)
    local player = obj.FromSpeaker
    local message =  obj.Message
    if player ~= LocalPlayer.Name then
        addMessage(message)
    end
end)