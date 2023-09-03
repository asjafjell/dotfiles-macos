# How to set up Virtual Linux for coding in Intellij IDEA

## Purpose 
The purpose of this setup is to be able to use Intellij IDEA in an `Citrix Workspace` with vaguely similary keyboard setup as on a Mac in order to code. 

This guide is based on a setup where the hardware is a Mac with a physical Norwegian keyboard, American English as layout and the virtual device is Ubuntu 22.04. It may work on other setups.

After doing this guide it will feel like coding on a Mac. Unfortunately, not all key bindings are like the default Mac layout for Intellij IDEA. In addition, not all keys on the bottom row can be mapped directly. You will have to press two keys for Option, and only one Command button acts as command. 

<img width="1045" alt="image" src="https://github.com/asjafjell/dotfiles/assets/720545/1c9c147a-e25c-47b6-9138-ae32af973202">

## Guide

1. Add keyboard layout `English (US, intl., with dead keys)` on Ubuntu.
2. In the Preferences of Citrix Workspace (![image](https://github.com/asjafjell/dotfiles/assets/720545/9b45085d-017e-47a5-8fe0-dca3aeab4c0c)),
   choose the double arrows in the right corner, `Keyboard` and set the following:
   
   ![image](https://github.com/asjafjell/dotfiles/assets/720545/3312a09c-4a06-4ab0-8d0a-4dc22b01823a).
   
   This will map 
   - Right ⌘ button to `Meta`, which we can map in Intellij IDEA to act as the Command button.
   - _Left Option + Left ⌘_ to `Alt / Option`     
3. Map `Windows` key to `Meta`. This is a bit backwards, but it does the trick for giving us a key which can act as a Command key (⌘). In Intellij IDEA, do the following:
  - _Help -> Edit Custom Properties_,
  - Add `keymap.windows.as.meta=true` to the file.
5. Install the plugin [macOS Keymap](https://plugins.jetbrains.com/plugin/13258-macos-keymap). This plugin adds keymap called _Intellij IDEA Classic (macOS)_ as a keymap. This will have a lot of shortcuts where `Meta` is used.
6. We must remove a few default shortcuts from Ubuntu in order to use them in Intellij. Remove with the following script:
   ```shell
   # To find other settings, please install app Dconf-Redigering. Most settings are found within 
   # org.gnome.desktop.wm.keybindings some within /org/gnome/mutter/
   # Choosing a shortcut, right click and copy gives a setting like the one under here. Emptying the
   # array removes all shortcuts for that functionality
   
   # Remove shorcuts for Activities:
   gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
   for i in $(seq 1 9); do gsettings set org.gnome.shell.keybindings switch-to-application-${i} '[]'; done

   # Remove Show Programs and Run Command:
   gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]" # Disable Alt + F1
   gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "[]" # Disable Alt + F2
   
   # Remove showe/hide desktop (cmd + D) - enables duplicating lines
   gsettings set org.gnome.desktop.wm.keybindings show-desktop "[]"
   ``` 
   Then manually set the following with the app Dconf-Edit (Dconf-Redigering):
   ```shell
   gsettings set org.gnome.mutter.keybindings toggle-tiled-left []
   gsettings set org.gnome.mutter.keybindings toggle-tiled-right []
   ```

7. [Install Frame switcher](https://plugins.jetbrains.com/plugin/7138-frame-switcher) which enables hot swapping between multiple instances of Intellij IDEA. Enables opening recent projects and open projects by search.
8. _Right click-menu_ keybinding. Add the following shortcut in _Settings -> Keymap_ -> `Show Context Menu`: `Meta + Shift + 0`. 
9. Search for _Go to_, set following
   - `Go to class`: `Ctrl + O`
   - `Go to class`: `Ctrl + Shift + O`
10. Search for _Move statement_, set following
   - `Move statement up`: `Ctrl + Shift + Up`
   - `Move statement down`: `Ctrl + Shift + Down`
11. Disable shortcuts for apps/mission control `Ctrl + Up` and `Ctrl + Down` on the Mac hostto enable next/previous method:
   - System settings -> Keyboard -> Keyboard Shortcuts -> Mission Control
   - Untick `Mission Control` and `Application Windows`

## Summary of nifty shortcuts after configuration
- `Start/end of line`: `fn + Left / Right` or `Cmd + Left / Right`
- `Page up/down`: `fn + Up / Down`
- `Selection for next occurence, Select/unselect`: `Ctrl + G / Ctrl + Shift + G`
- `Method, Next/Previous`: `Ctrl + Up/Down`
- `Move method up/down`: `Ctrl + Shift + Up/Down`
- `Error, Next/Previous`:`F2 / Shift + F2`
- `Selection, Increase/Decrease`: `Cmd + W / Cmd + Shift + W`
