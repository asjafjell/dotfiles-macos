# How to set up Virtual Linux for coding in Intellij IDEA

## Purpose 
The purpose of this setup is to be able to use Intellij IDEA in an `Citrix Workspace` with vaguely similary keyboard setup as on a Mac in order to code. 

This guide is based on a setup where the hardware is a Mac with a physical Norwegian keyboard, American English as layout and the virtual device is Ubuntu 20.04. It may work on other setups.

After doing this guide it will feel like coding on a Mac. Unfortunately, not all key bindings are like the default Mac layout for Intellij IDEA. In addition, not all keys on the bottom row can be mapped correctly. Only the right Option key will act as a Command key, and only in Intellij IDEA.

![Screenshot 2023-09-22 at 17 30 32](https://github.com/asjafjell/dotfiles/assets/720545/840917d1-c2a1-4a04-9bf1-e2a4391c3da0)

## Guide

1. Add keyboard layout `English (US, intl., with dead keys)` on Ubuntu.
2. In the Preferences of Citrix Workspace (![image](https://github.com/asjafjell/dotfiles/assets/720545/9b45085d-017e-47a5-8fe0-dca3aeab4c0c)),
   choose the double arrows in the right corner, `Keyboard` and set the following:

   ![image](https://github.com/asjafjell/dotfiles/assets/720545/5c3dd010-a273-40d8-98e4-b7bb40e07a6d)
   
   This will map: 
   - Right ⌘ button to `Meta`, which we can map in Intellij IDEA to act as the Command button.
   - _Left Option_ to `Alt / Option`
   - _Left ⌘_ to Super     
2. Map `Windows` key to `Meta`. This is a bit backwards, but it does the trick for giving us a key which can act as a Command key (⌘). In Intellij IDEA, do the following:
  - _Help -> Edit Custom Properties_,
  - Add `keymap.windows.as.meta=true` to the file.
5. Install the plugin [macOS Keymap](https://plugins.jetbrains.com/plugin/13258-macos-keymap). This plugin adds keymap called _Intellij IDEA Classic (macOS)_ as a keymap - please change to this mapping in Keymap settings. This mapping will have a lot of shortcuts where `Meta` is used.
6. We must remove a few default shortcuts from Ubuntu in order to use them in Intellij. Remove with the following script:
   ```shell
   # To find other settings, please install app Dconf-Redigering. Most settings are found within 
   # org.gnome.desktop.wm.keybindings some within /org/gnome/mutter/
   # Choosing a shortcut, right click and copy gives a setting like the one under here. Emptying the
   # array removes all shortcuts for that functionality
   
   # Remove shortcuts for Activities:
   gsettings set org.gnome.shell.extensions.dash-to-dock hot-keys false
   for i in $(seq 1 9); do gsettings set org.gnome.shell.keybindings switch-to-application-${i} '[]'; done

   # Remove Show Programs and Run Command:
   gsettings set org.gnome.desktop.wm.keybindings panel-main-menu "[]" # Disable Alt + F1
   gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "[]" # Disable Alt + F2
   
   # Remove showe/hide desktop (cmd + D) - enables duplicating lines
   gsettings set org.gnome.desktop.wm.keybindings show-desktop "[]"
   
   # Remove move window to left and right part of screen
   gsettings set org.gnome.mutter.keybindings toggle-tiled-left "[]"
   gsettings set org.gnome.mutter.keybindings toggle-tiled-right "[]"
   
   # Remove resizing shortcuts Alt + F7 / F8
   gsettings set org.gnome.desktop.wm.keybindings begin-resize "[]"
   gsettings set org.gnome.desktop.wm.keybindings begin-move "[]"
   
   # Disable right click window menu - to enable Quick definition / peek
   gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"
   
   # Disable CMD + P shortcut for monitor switching
   gsettings set org.gnome.mutter.keybindings switch-monitor "[]"    
   
   # Disable single press on left command button to open window switcher
   gsettings set org.gnome.mutter overlay-key '' 
   ```
6. Disable notification-shortcut. In Ubuntu settings, go to `Tastatursnarveier`, and remove shortcut `Vis varslingsliste`. 
6. Disable vis oversikt-shortcut. In Ubuntu settings, go to `Tastatursnarveier`, and remove shortcut `Vis oversikt`.
   Then remove one frome GUI so that we can select all text in a file:
   `Innstillinger -> Tastatursnarveier -> Vis alle programmer ` : Disable

7. [Install Frame switcher](https://plugins.jetbrains.com/plugin/7138-frame-switcher) which enables hot swapping between multiple instances of Intellij IDEA. Enables opening recent projects and open projects by search.

### Keybindings to set up

There are two different ways to add the shortcuts:
- Download the [Shortcuts file](IntelliJ%20IDEA%20Classic%20-%20Sjoffa%20edition.xml) and add it to `~/.config/Jetbrains/<CURRENT JETBRAINS VERSION>/keymaps`. Restart the IDE and choose the keymap in `Settings -> Keymap`.
- Add the shortcuts manually:
1. _Right click-menu_ keybinding. Add the following shortcut in _Settings -> Keymap_ -> `Show Context Menu`: `Meta + Shift + 0`. 
1. Search for _Go to_, set following
   - `Go to class` in `Go to by Name Actions`: `Ctrl + O`
   - `Go to file` in `Go to by Name Actions` : `Ctrl + Shift + O`
1. Search for _Move statement_, set following
   - `Move statement up`: `Ctrl + Shift + Up`
   - `Move statement down`: `Ctrl + Shift + Down`
1. Disable shortcuts for apps/mission control `Ctrl + Up` and `Ctrl + Down` on the Mac host to enable next/previous method:
   - System settings -> Keyboard -> Keyboard Shortcuts -> Mission Control
   - Untick `Mission Control` and `Application Windows`
1. Disable shortcut for `Spotlight -> Show Finder search window` on the Mac host.
1. Change shortcut `Find in files` to `Meta + Shift + F`
1. Change shortcut `Replace in files` to `Meta + Shift + R`
1. Change shortcut `Close tab` in `Editor close actions` to `Meta + W`
1. Change shortcut `Delete line` in `Editor Actions` to `Meta + Backspace`
1. Change shortcut `Show usages` to `Ctrl + Option + F7` (Remember `Option` is as described in picture above)
1. Change shortcut `Debug` in `Run/Debug` to `Ctrl + D`
1. Change shortcut `Debug context configuration` to `Ctrl + Shift + D`
1. Change shortcut `Run` in `Run/Debug` to `Ctrl + R`
1. Change shortcut `Run context configuration` to `Ctrl + Shift + R`
1. Change shortcut `Quick documentation` to `F1`
1. Change shortcut `Left` in `Navigate` to `Meta + Ctrl + Left` 
1. Change shortcut `Right` in `Navigate` to `Meta + Ctrl + Right` 
1. Add shortcut `Comment with line comment` to `Meta + Minus` or `Meta + /`
1. Change shortcut `Quick definition` to `Option + Space` (Peek)
1. Change shortcut `Run` in `Main menu - Run` to `Ctrl + Option + R`
1. Change shortcut `Debug` in `Main menu - Debug` to `Ctrl + Option + D`
1. Change shortcut `Resume Program` to `Cmd + Option + R`
1. Change shortcut `Select next tab` to `Cmd + Shift + Right` (Choose keep the other places it is used)
1. Change shortcut `Select previous tab` to `Cmd + Shift + Left` (Choose keep the other places it is used)
1. Change Shortcut `Extend Selection  in `Editor Actions` to `Alt + Up`
1. Change Shortcut `Shrink Selection  in `Editor Actions` to `Alt + Down`

## Summary of nifty shortcuts after configuration
- `Start/end of line`: `fn + Left / Right` or `Cmd + Left / Right`
- `Page up/down`: `fn + Up / Down`
- `Selection for next occurence, Select/unselect`: `Ctrl + G / Ctrl + Shift + G`
- `Method, Next/Previous`: `Ctrl + Up/Down`
- `Move method up/down`: `Ctrl + Shift + Up/Down`
- `Error, Next/Previous`:`F2 / Shift + F2`
- `Selection, Increase/Decrease`: `Alt + Up / Alt Down`
- `Find in files`: `Meta + Shift + F`
- `Replace in files`: `Meta + Shift + R`
- `Close tab`: `Meta + W`
- `Delete line`: `Meta + Backspace`
- `Open scratch file`: `Ctrl + Shift + N`
- `Show usages` to `Ctrl + Option + F7`
- `Debug` previous run: `Ctrl + D`
- `Debug in current context`: `Ctrl + Shift + D`
- `Toggle line breakpoint`: `CMD + F8`
- `Evaluate expression`: `Alt + F8`
- `Quick evaluate expression`: `Cmd + Alt + F8`
- `Quick documentation`: F1
- `Run` by showing the Run-configuration menu: `Ctrl + Option + R` 
- `Debug` by showing the Debug-configuration menu: `Ctrl + Option + D`
- `Resume Program`: `Cmd + Option + R`
- `Select next/previous tab`: `Cmd + Shift + Right/Left`


# When things go wrong

## App menu is hidden

- Install and start Gnome tweaks
   ```shell
   sudo apt install gnome-tweaks
   gnome-tweaks
   ```
- Choose `Utvidelser`
- Activate with slider switch in the top.
