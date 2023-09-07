# Allow comments in scripts
# Makes hash char a signal for comments in scripts
setopt interactivecomments

######################
#      ALIAS         #
######################

# Hvordan gjøre sånn at stier kan brukes som erstatning i kommandoer, ikke bare for å gå til en mappe
# Se https://askubuntu.com/questions/758496/how-to-make-a-permanent-alias-in-oh-my-zsh for mer info
setopt AUTO_CD

########################
# Oh-my-zsh-config     #
########################

# Disable security verification
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

################################
## Zsh-config                 ##
################################

# Manage Oh-My-Zsh plugins with Antigen

# For MAC
# source /opt/homebrew/share/antigen/antigen.zsh

# For Linux (after downloading antigen.zsh to this repo root)
source ~/.dotfiles/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo - robbyrussell's oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle cowboyd/zsh-volta --branch v1

# Load theme
antigen theme af-magic

antigen apply

#################################
## Jenv			       ##
#################################
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"
# export PATH="/usr/local/sbin:$PATH"

#################################
## Smarte kommandoer           ##
#################################

alias hgrep="fc -liD 10 | grep"

# Delete merged branches
alias delete-local-branches="git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done"

#################################
## Work apps setup             ##
#################################

# Import all passwords
if [ -f ~/.zshpasswords ]; then
    source ~/.zshpasswords
else
    print "~/.zshpasswords not found."
fi

# Jabba setup (added by install script at Github repo)
[ -s "/home/alesja/.jabba/jabba.sh" ] && source "/home/alesja/.jabba/jabba.sh"
