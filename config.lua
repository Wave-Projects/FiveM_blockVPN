Config = {} -- Don't touch this line

Config.ServerName = 'Your Server Name' -- Name of the server

Config.Locales = {
    VPN_Detected = 'VPN Detected', -- Title of the card
    VPN_Detected_Message =
    'Joining with a VPN is not allowed. This can also be caused by things like cloud gaming!\nIf you are not using a VPN, you can create a ticket in the Discord', -- Message of the card
    API_Error = '[🚧]: An error occurred in the API', -- Error message when the API fails
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
