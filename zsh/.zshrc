# JAVA
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

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

hash -d digi=~/projects/digipost/
hash -d dp=~/projects/digipost/digipost/
hash -d sign=~/projects/digipost/signering/
hash -d signf=~/projects/digipost/signering-frontend/
hash -d signd=~/projects/digipost/signature-api-client-dotnet 
hash -d pi=~/projects/private/hue-server

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

######################
#     DIGIPOST       #
######################

DIGIPOST_HOME=$HOME/projects/digipost
DPOST_REPOS_PATH=/projects/digipost

source $HOME/.digipostrc

# Alias pass-kommandoer slik  at vi kan alternere lettere mellom de
alias dppass="export PASSWORD_STORE_DIR=${DPOST_REPOS_PATH}/digipost-passwords"
alias vpnpass="export PASSWORD_STORE_DIR=${DPOST_REPOS_PATH}/vpn-passwords"

############################
## Oppsett dotnet og mono ##
############################

# Link up mono install path
export PATH=/Library/Frameworks/Mono.framework/Versions/Current/bin:$PATH

# Link up dotnet install path
# ln -s /usr/local/share/dotnet/dotnet /usr/local/bin/

# added by travis gem
[ -f /Users/aas/.travis/travis.sh ] && source /Users/aas/.travis/travis.sh
export PATH="/usr/local/opt/openssl/bin:$PATH"

#################################
## Jenv			       ##
#################################
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="/usr/local/sbin:$PATH"
