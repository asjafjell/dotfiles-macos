# Point to .dotfiles-macos repo
export DOTFILES=~/.dotfiles-macos

############
# Homebrew #
############

export PATH="$(brew --prefix)/bin:$PATH"

# Allow comments in scripts
# Makes hash char a signal for comments in scripts
setopt interactivecomments

#################################
## Jenv			       ##
#################################
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/usr/local/sbin:$PATH"

if which jenv > /dev/null; then eval "$(jenv init -)"; fi

#################################
## Work apps setup             ##
#################################

# Intellij
export PATH="/Applications/IntelliJ IDEA.app/Contents/bin:$PATH"
