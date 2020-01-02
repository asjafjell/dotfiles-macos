# Dotfiles

## Install apps

### In Terminal
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor # Do all fixes
brew cask install iterm2
```

```
brew install caskroom/cask/brew-cask
brew install brew-cask-completion
brew tap caskroom/cask
brew tap caskroom/versions

brew install zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew cask install intellij-idea slack google-chrome spotify spectacle keystore-explorer
brew install tig
```

## Setup commandos 
Consider adding these to a separate scripts file

```
# Make sure tags are pushed by default in Git
git config --global push.followTags true

# Clone dotfiles repo to machine
git clone git@github.com:asjafjell/dotfiles.git ~/.dotfiles

# Symlink Zsh config file to dotfiles repo
ln -s ~/.dotfiles/zsh/.zshrc ~/.zshrc

# Symlink SSH config to dotfiles repo
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

# Add 'subl' as a command for running sublime from Terminal. More info here:https://gist.github.com/olivierlacan/1195304
ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

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

## Other interesting dotfiles used for inspo
1. [nicsp](https://github.com/nicksp/dotfiles/blob/master/osx/set-defaults.sh) (See the script in repo for setting up MacOS-spesific things)
1. And all the others at [Github](https://dotfiles.github.io/)
