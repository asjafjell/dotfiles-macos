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

# Disable security verification
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

################################
## Zsh-config                 ##
################################

# Manage Oh-My-Zsh plugins with Antigen
source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Bundles from the default repo - robbyrussell's oh-my-zsh

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-autosuggestions

# Load theme
antigen theme af-magic

antigen apply

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

# Delete merged branches
alias delete-local-branches = for branch in $(git branch -v | grep "gone" | awk '{print $1}'); do git branch -d $branch; done

#################################
## Nvm setup                   ##
#################################

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


#################################
## Work apps setup             ##
#################################

#Sqlite
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/sqlite/lib"
export CPPFLAGS="-I/usr/local/opt/sqlite/include"

#Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

#Getttext
export PATH="/usr/local/opt/gettext/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/gettext/lib"
export CPPFLAGS="-I/usr/local/opt/gettext/include"
export PATH="/usr/local/opt/ncurses/bin:$PATH"

#Intellij
export PATH="/Applications/IntelliJ IDEA.app/Contents/bin:$PATH"
