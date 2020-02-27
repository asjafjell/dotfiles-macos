############
# Homebrew #
############

export PATH="$(brew --prefix)/bin:$PATH"

# Shell completion, https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

######################
#      ALIAS         #
######################

# Hvordan gjøre sånn at stier kan brukes som erstatning i kommandoer, ikke bare for å gå til en mappe
# Se https://askubuntu.com/questions/758496/how-to-make-a-permanent-alias-in-oh-my-zsh for mer info
setopt AUTO_CD

########################
# Oh-my-zsh-config     #
########################

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/aas/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"


# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.dotfiles/zsh/ZSH_CUSTOM

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#################################
## Jenv			       ##
#################################
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/usr/local/sbin:$PATH"

#################################
## Smarte kommandoer           ##
#################################

alias hgrep="fc -liD 10 | grep"

