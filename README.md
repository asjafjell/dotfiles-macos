# Dotfiles

## Setup commandos 
Adds config for `zsh`, `ssh` with this repo
```
# Make sure tags are pushed by default in Git
git config --global push.followTags true

# Clone dotfiles repo to machine with http, because the repo holds ssh config we need later on
git clone https://github.com/asjafjell/dotfiles.git ~/.dotfiles

# Symlink Zsh config file to dotfiles repo
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Symlink SSH config to dotfiles repo
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

```

## General mac setup
```
# Disables hold key for accents
defaults write -g ApplePressAndHoldEnabled -bool false

# Set key repeat more aggressive than what can be done in Settings
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable inline attachments in Mail.app (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Finder
###############################################################################

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Different screenshots folder
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Disable autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
```

## Set up .ssh key
1. Download .ssh private key, move to .ssh folder, and create public key
```
mkdir ~/.ssh/
cp ~/Downloads/id_rsa ~/.ssh/
chmod 400 ~/.ssh/id_rsa #Fixes error Permissions 0644 for '/Users/*/.ssh/id_rsa' are too open.
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
```

Follow the guide at [Github for SSH setup](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) if any problems arise.

## Install apps

### In Terminal
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # Do all fixes
brew cask install iterm2
```

### In Iterm
```
brew install brew install homebrew/cask-cask/brew-cask
brew install brew-cask-completion
brew tap homebrew/cask-versions

brew install zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew cask install google-chrome intellij-idea slack spotify keystore-explorer fantastical inkdrop
brew install tig
brew cask install bettertouchtool #Enable cloud backup in settings. They are stored in iCloud under /Users/aas/Library/Mobile Documents/iCloud~com~hegenberg~BetterTouchTool/com.mentalfaculty.ensembles.clouddata
```

#### Installing Iterm plugins with Antigen
`.zshrc` defines plugin installation with Antigen. To do that, Anttigen.zsh must be present:
```sh
mkdir /usr/local/share/antigen
cd /usr/local/share/antigen
curl -L git.io/antigen > antigen.zsh
```
See more info about Antigen [here](https://github.com/zsh-users/antigen)

#### Intalling Java:

```
brew cask install adoptopenjdk
brew tap AdoptOpenJDK/openjdk
brew cask install AdoptOpenJDK/openjdk/adoptopenjdk{8,11,12,13}
brew install jenv

# Add all versions to java 
ls Library/Java/JavaVirtualMachines 
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-12.jdk/Contents/Home
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-13.jdk/Contents/Home

# Enable maven plugin
jenv enable-plugin maven
jenv enable-plugin export

```
See more info about OpenJDK [here](https://github.com/AdoptOpenJDK/homebrew-openjdk)


## Other interesting dotfiles used for inspo
1. [nicsp](https://github.com/nicksp/dotfiles/blob/master/osx/set-defaults.sh) (See the script in repo for setting up MacOS-spesific things)
1. And all the others at [Github](https://dotfiles.github.io/)
