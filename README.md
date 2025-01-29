# ~/.dotfiles-macos

## Overview

- [Requirements](#requirements)
- [Installation](#installation)
- [Customization](#customize)
- [Content](#content)

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


## Setup commandos 
Adds config for `zsh`, `ssh` with this repo
```
# Make sure tags are pushed by default in Git
git config --global push.followTags true
git config --global user.name "Aleksander Aas Sjåfjell"
git config --global user.email github@sjafjell.no

# Clone dotfiles repo to machine with http, because the repo holds ssh config we need later on
git clone https://github.com/asjafjell/dotfiles.git ~/.dotfiles

#############################################
# Symlink Zsh config file to dotfiles repo  #
#############################################

ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Symlink SSH config to dotfiles repo
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

```


## Set up .ssh key
1. Enable SSH in 1Password
2. Activate all bells and whistles and let 1Password do it's magic.
3. If you are not asked for a login by 1Password when doing e.g. `git pull`, see [the official guide here](https://developer.1password.com/docs/ssh/get-started/#step-3-turn-on-the-1password-ssh-agent) 

## Install apps

### In Terminal
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew doctor # Do all fixes
brew install iterm2 --cask
```

### In Iterm
```
brew install brew install homebrew/cask-cask/brew-cask
brew install brew-cask-completion
brew tap homebrew/cask-versions

brew install zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew install --cask intellij-idea spotify keystore-explorer fantastical 1password notion
```

#### Installing Iterm plugins with Antigen
```
brew install antigen
```

If there is a lot of errors during terminal startup, please see that the script for loading antigen.zsh matches the *caveat* in the output of 
```
brew info antigen
```

See more info about Antigen [here](https://github.com/zsh-users/antigen)

#### Iterm as dropdown with shortcut
[This guide from Xun Zhou at dev.io](https://dev.to/vikbert/drop-down-iterm2-in-macos-2od)

#### Intalling Java:

```
# Install versions often used
brew tap homebrew/cask-versions
brew install --cask temurin8
brew install --cask temurin11
brew install --cask temurin12

# Install latest
brew install --cask temurin
brew install jenv

# Add all versions to jenv
ls Library/Java/JavaVirtualMachines 
jenv add /Library/Java/JavaVirtualMachines/temurin-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/temurin-12.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/temurin-[replace with latest].jdk/Contents/Home

# Enable maven plugin - makes maven respect Jenv.
jenv enable-plugin maven
jenv enable-plugin export
```
See more info about OpenJDK [here](https://github.com/AdoptOpenJDK/homebrew-openjdk)


## Other interesting dotfiles used for inspo
1. [nicsp](https://github.com/nicksp/dotfiles/blob/master/osx/set-defaults.sh) (See the script in repo for setting up MacOS-spesific things)
1. And all the others at [Github](https://dotfiles.github.io/)
