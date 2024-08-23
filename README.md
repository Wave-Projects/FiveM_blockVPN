# BlockVPN

BlockVPN is a resource for FiveM servers that detects and blocks connections from players using VPNs or proxies.

## Features

- **VPN Detection:** Identifies VPN connections using an IP intelligence API.
- **Adaptive Card Display:** Shows a customizable adaptive card to players detected using VPNs.
- **Customizable Settings:** Personalize server name, messages, and buttons on the adaptive card.
- **Adaptive Card Control:** Toggle the adaptive card feature on or off.
- **Country Check:** Verify and restrict connections based on the player's country, with the option to whitelist specific countries.

## Installation

1. Ensure you have the necessary files in your FiveM server's resource folder.
2. Add `start FiveM_blockVPN` to your server.cfg file.

## Configuration

You can configure BlockVPN by editing the `config.lua` file.

### Configurations

### AdaptiveCard
- **Description:** Enable or disable the adaptive card feature.

### CountryCheck
- **Description:** Enable or disable the Country Check feature.

### AllowedCountrys
- **Description:** List of whitelisted countries.

#### ServerName
- **Description:** Name of your FiveM server.
- **Usage:** Update `Config.ServerName` to your server's name.

#### Locales

- **VPN_Detected**
  - **Description:** Title displayed when a VPN is detected.
- **VPN_Detected_Message**
  - **Description:** Message displayed when a VPN is detected.
- **API_Error**
  - **Description:** Error message shown when the API fails.
- **Country_Detected**
  - **Description:** Title displayed when a connection is made from a non-whitelisted country.
- **Country_Detected_Message**
  - **Description:** Message displayed when a connection is made from a non-whitelisted country.

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

## Issues
If you encounter any issues with BlockVPN, please let us know, and we will fix them as soon as possible.