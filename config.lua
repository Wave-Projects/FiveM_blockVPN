Config = {}                            -- Don't touch this line

Config.ServerName = 'Your Server Name' -- Name of the server

Config.VersionCheck = true             -- Check for the latest version of the script

Config.AdaptiveCard = true             -- Enable or disable the adaptive card

Config.CountryCheck = false
Config.AllowedCountrys = { -- Here you can add the country codes that are allowed to join the server
    ["NL"] = true,
    ["US"] = true
}

-- More info about the country codes can be found here: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2

Config.Locales = {
    API_Checking = '[🚧]: Checking for VPN', -- Message when the API is checking for VPN
    VPN_Detected = 'VPN Detected', -- Title of the card
    VPN_Detected_Message =
    'Joining with a VPN is not allowed. This can also be caused by things like cloud gaming!\nIf you are not using a VPN, you can create a ticket in the Discord', -- Message of the card
    API_Error = '[🚧]: An error occurred in the API', -- Error message when the API fails
    Country_Detected = 'Country Not Allowed', -- Title of the card
    Country_Detected_Message =
    'You are not allowed to join from this country. If you think this is a mistake, you can create a ticket in the Discord', -- Message of the card
}

Config.Buttons = {                          -- Here you can add buttons to the card (max 5 buttons)
    {
        title = 'Discord',                  -- Title of the button
        url = 'https://discord.gg/example', -- URL of the button
        style = 'positive',                 -- positive, destructive, default
    },
    -- Add more buttons here
}

-- More info about the buttons can be found here: https://adaptivecards.io/explorer/Action.OpenUrl.html
