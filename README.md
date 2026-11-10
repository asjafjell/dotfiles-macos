![Banner.webp](Banner.webp)

## Overview

- [Requirements](#requirements)
- [Installation](#installation)
- [Customization](#customize)
- [Terminal setup](#terminal-setup)
- [⚡ Shell tricks](#-shell-tricks)

## Requirements

To be able to install the dotfiles, you are going to need `git` and various developer tools. These are shipped with the macos **command-line-tools.** To install these run:

```
xcode-select --install
```

You also need to have [Homebrew](https://brew.sh) installed. Follow instructions on their website to get started.

## Installation

The dotfiles are configured to be installed under `~/.dotfiles-macos/`by default and should be cloned into `$HOME`.
**See** [location](#Location) to change this.

1. Clone this repository with:

```
git clone https://github.com/asjafjell/dotfiles-macos.git ~/.dotfiles-macos
```

> [!IMPORTANT]  
> Beware that some of the settings (especially those for [macos](.macos)) may require `sudo` privileges.

2. Run the python installation script with temporary reference to dotfiles

```
export DOTFILES=~/.dotfiles-macos
python3 install.py
```

## Customize

Everything can be customized, and it is recommended to get an overlook of what the dotfiles install and adjust them to preferred settings.

### Location

If you want to install the dotfiles somewhere else some paths are dependent on the DOTFILES variable.

in **`.zshrc`**

```
export DOTFILES="$HOME/.dotfiles-macos/"
```

> [!NOTE]
> There also is a reference to `$DOTFILES` in `install.py` which will have to be updated.

## Set up .ssh key
1. Open Proton Pass (installed from the Brewfile) and log in.
2. In Proton Pass settings, turn on the SSH agent. It listens on `~/.ssh/proton-pass-ssh-agent.sock`, which `ssh/config` and `.zshrc` point to.
3. Make sure the SSH key matching `signingkey` in `git/.gitconfig` is stored in Proton Pass. Check with `ssh-add -l` in a new shell, then `ssh -T git@github.com`.

## Terminal setup

### Install Oh My Zsh 

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## ⚡ Shell tricks

The stuff that is easy to forget. Run `tips` in a terminal to print this section, and the shell shows a one-line reminder in the first terminal you open each day.

### Finding things

| Keys / command | What it does |
|---|---|
| `Ctrl+R` | Search your whole shell history ([atuin](https://atuin.sh)). The numbers on the left are how long the command took and how long ago you ran it. `Alt+1`–`9` runs that row directly. |
| `Ctrl+T` | Fuzzy-find a file under the current folder and paste its path where the cursor is. `Tab` marks several. |
| `Alt+C` | Fuzzy-find a folder and `cd` into it. |
| `Tab` | Completion menu you can type in to filter ([fzf-tab](https://github.com/Aloxaf/fzf-tab)). On `cd` it previews the folder. |
| `z <part of path>` | Jump to the folder you use most that matches, e.g. `z dotf` ([zoxide](https://github.com/ajeetdsouza/zoxide)). |
| `zi` | Same, but pick from a list. |

### Looking at things

| Command | What it does |
|---|---|
| `ls` | [eza](https://eza.rocks), folders first. |
| `ll` | Long list including hidden files and git status per file. |
| `tree` | Folder tree. |
| `cat <file>` | [bat](https://github.com/sharkdp/bat), with syntax highlighting. Acts like plain `cat` when piped. |

### Terminal

| Keys | What it does |
|---|---|
| `Caps Lock` | Show or hide Ghostty from anywhere (Karabiner + Hammerspoon). |
| `Cmd+↑` / `Cmd+↓` | Jump to the previous / next prompt in Ghostty. |
| `Cmd+Shift+↑` / `Cmd+Shift+↓` | Same, with the shift variant of the binding. |
| Type a folder name | `cd` into it without typing `cd` (`AUTO_CD`). |

### Good to know

- Typing gives greyed-out suggestions from history. `→` accepts them.
- Green or red command text while typing tells you whether the command exists. Underlined text is a path that exists.
- `nvm` loads the first time you run it, to keep startup fast. Node is on `PATH` from the start.
- `JAVA_HOME` follows jenv when you change folder or run `jenv shell/local/global`.
