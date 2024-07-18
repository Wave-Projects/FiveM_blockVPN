local adaptiveCard = {
    ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
    ["type"] = "AdaptiveCard",
    ["version"] = "1.6",
    ["body"] = {
        {
            ["type"] = "TextBlock",
            ["text"] = Config.ServerName .. ' - ' .. Config.Locales.VPN_Detected,
            ["weight"] = "bolder",
            ["size"] = "large",
            ["horizontalAlignment"] = "center",
            ["wrap"] = true,
        },
        {
            ["type"] = "TextBlock",
            ["text"] = Config.Locales.VPN_Detected_Message,
            ["size"] = "medium",
            ["horizontalAlignment"] = "center",
            ["wrap"] = true,
        },
        {
            ["type"] = "ActionSet",
            ["horizontalAlignment"] = "center",
            ["actions"] = {}
        },
    },
}

Citizen.CreateThread(function()
    if Config.Buttons then
        for _, button in ipairs(Config.Buttons) do
            if button.title and button.url and button.style then
                table.insert(adaptiveCard.body[3].actions, {
                    ["type"] = "Action.OpenUrl",
                    ["title"] = button.title,
                    ["url"] = button.url,
                    ["style"] = button.style,
                })
            end
        end
    end
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local playerIP = GetPlayerEndpoint(src)

    deferrals.defer()

    if not playerIP then
        deferrals.done(Config.Locales.API_Error)
        return
    end

    PerformHttpRequest("http://ip-api.com/json/" .. playerIP .. "?fields=66846719", function(err, text, headers)
        local data = json.decode(text)
        if data and data.status == "success" then
            if data.proxy then
                deferrals.presentCard(adaptiveCard)
                return
            else
                deferrals.done()
                return
            end
        else
            deferrals.done(Config.Locales.API_Error)
            return
        end
    end)
end)
