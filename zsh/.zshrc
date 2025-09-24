#################################
## Shell                       ##
#################################

# Make sure Homebrew is in path
export PATH="/opt/homebrew/bin:$PATH"

# Point to .dotfiles-macos repo
export DOTFILES=~/.dotfiles-macos

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

if [[ $TERMINAL_EMULATOR == "JetBrains-JediTerm" ]]; then
 [[ ! -f $DOTFILES/zsh/.p10k-intellij.zsh ]] || source $DOTFILES/zsh/.p10k-intellij.zsh
else
 [[ ! -f $DOTFILES/zsh/.p10k-ghostty.zsh ]] || source $DOTFILES/zsh/.p10k-ghostty.zsh
fi

#################################
## AUTOCOMPLETE SETUP          ##
#################################

# Zsh Autocomplete
################################
# - Is installed via brew (see brewfile)
# - Gives the terminal a list of command menus and bit more info
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Remap Shift+TAB to zsh-autocomplete menu first item
bindkey -M menuselect '^[[Z' reverse-menu-complete

# Native Zsh auto completion setup
# Docs here: https://zsh.sourceforge.io/Doc/Release/Options.html
setopt complete_in_word   # insert common prefix on first TAB


# Zsh Autosuggestions
################################
# - Is installed via git clone (see install script)
# - Gives the 'greyed out' suggestions when typing
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Native Autocomplete
################################

# Remap TAB to native completion
bindkey '^I' expand-or-complete

# Autojump - added from brew install info
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh


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

# pnpm
export PNPM_HOME="/Users/aas/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

##################################
## Aliases                     ##
##################################


##################################
## Zsh Options                 ##
##################################

setopt AUTO_CD
