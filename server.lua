local AlreadyChecked = {}
local AlreadyCheckedCountry = {}
local Buttons = {}

local adaptiveCard = {
    VPN_Detected = {
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
                ["actions"] = Buttons
            },
        },
    },
    Country_Detected = {
        ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
        ["type"] = "AdaptiveCard",
        ["version"] = "1.6",
        ["body"] = {
            {
                ["type"] = "TextBlock",
                ["text"] = Config.ServerName .. ' - ' .. Config.Locales.Country_Detected,
                ["weight"] = "bolder",
                ["size"] = "large",
                ["horizontalAlignment"] = "center",
                ["wrap"] = true,
            },
            {
                ["type"] = "TextBlock",
                ["text"] = Config.Locales.Country_Detected_Message,
                ["size"] = "medium",
                ["horizontalAlignment"] = "center",
                ["wrap"] = true,
            },
            {
                ["type"] = "ActionSet",
                ["horizontalAlignment"] = "center",
                ["actions"] = Buttons
            },
        },
    }
}

local function initButtons()
    if not Config.AdaptiveCard then return end
    if Config.Buttons then
        for _, button in ipairs(Config.Buttons) do
            if button.title and button.url and button.style then
                table.insert(Buttons, {
                    ["type"] = "Action.OpenUrl",
                    ["title"] = button.title,
                    ["url"] = button.url,
                    ["style"] = button.style,
                })
            end
        end
    end
end

local function handleDeferral(deferrals, reason, card)
    if Config.AdaptiveCard then
        deferrals.presentCard(card)
    else
        deferrals.done(reason)
    end
end

Citizen.CreateThread(initButtons)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local src = source
    local playerIP = GetPlayerEndpoint(src)

    deferrals.defer()
    deferrals.update(Config.Locales.API_Checking)

    if Config.AdaptiveCard then
        Wait(250)
    end

    if not playerIP then
        deferrals.done(Config.Locales.API_Error)
        return
    end

    if AlreadyChecked[playerIP] then
        handleDeferral(deferrals, Config.Locales.VPN_Detected .. '\n' .. Config.Locales.VPN_Detected_Message,
            adaptiveCard.VPN_Detected)
        return
    elseif AlreadyCheckedCountry[playerIP] then
        handleDeferral(deferrals, Config.Locales.Country_Detected .. '\n' .. Config.Locales.Country_Detected_Message,
            adaptiveCard.Country_Detected)
        return
    end

    PerformHttpRequest("http://ip-api.com/json/" .. playerIP .. "?fields=66846719", function(err, text, headers)
        local data = json.decode(text)
        if data and data.status == "success" then
            if data.proxy or data.hosting then
                AlreadyChecked[playerIP] = true
                handleDeferral(deferrals, Config.Locales.VPN_Detected .. '\n' .. Config.Locales.VPN_Detected_Message,
                    adaptiveCard.VPN_Detected)
            else
                if Config.CountryCheck and not Config.AllowedCountrys[data.countryCode] then
                    AlreadyCheckedCountry[playerIP] = true
                    handleDeferral(deferrals,
                        Config.Locales.Country_Detected .. '\n' .. Config.Locales.Country_Detected_Message,
                        adaptiveCard.Country_Detected)
                else
                    AlreadyChecked[playerIP] = false
                    AlreadyCheckedCountry[playerIP] = false
                    deferrals.done()
                end
            end
        else
            deferrals.done(Config.Locales.API_Error)
        end
    end)
end)

if Config.VersionCheck then
    Citizen.CreateThread(function()
        local updatePath = "/Wave-Projects/FiveM_blockVPN"
        local resourceName = "FiveM_blockVPN (" .. GetCurrentResourceName() .. ")"
        local versionUrl = "https://raw.githubusercontent.com" .. updatePath .. "/master/version"

        local function parseVersion(version)
            local major, minor, patch = version:match("^(%d+)%.(%d+)%.(%d+)$")
            return tonumber(major), tonumber(minor), tonumber(patch)
        end

        local function isVersionNewer(current, latest)
            local curMajor, curMinor, curPatch = parseVersion(current)
            local latMajor, latMinor, latPatch = parseVersion(latest)

            if not curMajor or not latMajor then
                return nil, "Invalid version format."
            end

            if curMajor < latMajor then
                return true
            elseif curMajor > latMajor then
                return false
            elseif curMinor < latMinor then
                return true
            elseif curMinor > latMinor then
                return false
            elseif curPatch < latPatch then
                return true
            else
                return false
            end
        end

        PerformHttpRequest(versionUrl, function(err, responseText, headers)
            if err ~= 200 then
                print('[^1ERROR^0] Failed to check for updates: HTTP ' .. err)
                return
            end

            local curVersion = GetResourceMetadata(GetCurrentResourceName(), "version", 0)
            if not curVersion then
                print('[^1ERROR^0] Could not retrieve the current version of ' .. resourceName)
                return
            end

            local isUpdateAvailable, errorMsg = isVersionNewer(curVersion, responseText)

            if errorMsg then
                print('[^4Wave-Projects^0][^1Error^0] Version check error: ' .. errorMsg)
            elseif isUpdateAvailable == nil then
                print('[^4Wave-Projects^0][^1Error^0] Unable to compare versions.')
            elseif isUpdateAvailable then
                print('[^4Wave-Projects^0][^1Error^0] ' ..
                    resourceName .. ' is outdated. Consider updating to the latest version.')
                print('[^4Wave-Projects^0][^1Error^0] Current version: ' .. curVersion)
                print('[^4Wave-Projects^0][^1Error^0] Latest version: ' .. responseText)
            elseif not isUpdateAvailable then
                if curVersion ~= responseText then
                    print('[^4Wave-Projects^0][^1Error^0] ' ..
                        resourceName .. ' is using a version newer than the latest version available.')
                    print('[^4Wave-Projects^0][^1Error^0] Current version: ' .. curVersion)
                    print('[^4Wave-Projects^0][^1Error^0] Latest version: ' .. responseText)
                else
                    print("[^4Wave-Projects^0][^2Success^0] " .. resourceName .. " is up to date, have fun!")
                end
            end
        end, "GET")
    end)
end
