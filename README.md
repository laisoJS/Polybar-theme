# Modules Overview

For further information go read the [Polybar wiki](https://github.com/polybar/polybar/wiki)
### battery.ini

- **Type:** Internal Battery Module
- **Description:** Monitors the battery status of the system, displaying its current capacity and charging status.
- **How to Modify:**
  - To change the battery to monitor, locate the `battery =` line and replace `BAT0` with the appropriate battery identifier for your system.
  - Similarly, you can change the adapter to monitor by modifying the `adapter =` line accordingly.

### date.ini

- **Type:** Internal Date Module
- **Description:** Displays the current date and time on the desktop panel.
- **How to Modify:**
  - To change the date format, edit the `date =` and `date-alt =` lines with the desired date formats using the appropriate placeholders.
  - Adjust the label foreground color by modifying the `label-foreground =` line.

### network.ini

- **Type:** Custom Script Module
- **Description:** Displays network-related information such as network connection status or usage.
- **How to Modify:**
  - If needed, update the script path in the `exec =` line to point to the script that retrieves network information.
  - Change the label foreground color by editing the `label-foreground =` line.
  - Modify the double-click action by changing the command in the `double-click-left =` line.

### playerctl.ini

- **Type:** Custom Script Module
- **Description:** Controls media playback and displays information about the currently playing media.
- **How to Modify:**
  - Customize the player control script in the `exec =` line to suit your media player.
  - Adjust click actions for playback controls (previous, play/pause, next) by modifying the `click-` lines.
  - Optionally, change the font and label formatting properties as needed.

### power.ini

- **Type:** Custom Menu Module
- **Description:** Creates a hierarchical power menu for system power management actions.
- **How to Modify:**
  - Define the actions and icons for various power management tasks in the `menu-x-y` sections.
  - To change the commands executed for actions like reboot, shutdown, etc., update the `exec =` lines with the desired commands.
  - Adjust foreground colors for menu items by modifying the `menu-x-y-foreground =` lines.
  - Customize the double-click action for network management by changing the command in the `double-click-left =` line.

### pulseaudio.ini

- **Type:** Internal PulseAudio Module
- **Description:** Monitors and controls audio playback volume using PulseAudio.
- **How to Modify:**
  - Change the audio sink to monitor by replacing the identifier in the `sink =` line with the appropriate sink name for your system.
  - Customize volume icons and labels by modifying the `ramp-volume-` and `label-` lines.
  - Adjust the middle-click action to open a different audio control tool by changing the command in the `click-middle =` line.