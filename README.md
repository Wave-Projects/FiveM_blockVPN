# BlockVPN

BlockVPN is a resource for FiveM servers that detects and blocks connections from players using VPNs or proxies.

## Features

- Detects VPN connections using IP intelligence API.
- Displays an adaptive card to players detected with VPNs.
- Allows customization of server name, messages, and buttons displayed on the card.

## Installation

1. Ensure you have the necessary files in your FiveM server's resource folder.
2. Add `start blockvpn` to your server.cfg file.

## Configuration

You can configure BlockVPN by editing the `config.lua` file.

### Configurations

#### ServerName
- **Description:** Name of your FiveM server.
- **Usage:** Update `Config.ServerName` to your server's name.

#### Locales
- **VPN_Detected**
  - **Description:** Title displayed on the adaptive card when VPN is detected.
- **VPN_Detected_Message**
  - **Description:** Message displayed on the adaptive card when VPN is detected.
- **API_Error**
  - **Description:** Error message displayed when the API fails.

#### Buttons
- **Description:** Array of buttons displayed on the adaptive card (maximum 5 buttons).
- **Properties:**
  - **title:** Title of the button.
  - **url:** URL the button directs to.
  - **style:** Style of the button (positive, destructive, default).

### Customizing Adaptive Card Behavior

You can customize the adaptive card's appearance and behavior directly in the `server.lua` file. Refer to [Adaptive Cards Documentation](https://adaptivecards.io/explorer/Action.OpenUrl.html) for more details on configuring actions and layouts.

## Usage

When a player with a VPN attempts to connect to your server, they will be presented with an adaptive card displaying the configured message and buttons. Players not using a VPN will connect without interruption.