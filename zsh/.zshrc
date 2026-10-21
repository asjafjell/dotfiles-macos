#################################
## Shell                       ##
#################################

# Make sure Homebrew is in path
export PATH="/opt/homebrew/bin:$PATH"

# Point to .dotfiles-macos repo
export DOTFILES=~/.dotfiles-macos

# Cache for generated init scripts (see _zshrc_cached_source)
_zshrc_cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zshrc"

# Source the output of a slow init command from a cache file instead of running
# it on every shell start. The cache is rebuilt when the command's binary
# (symlinks resolved) moves or gets newer than the cache, i.e. after an upgrade.
# Usage: _zshrc_cached_source <name> <binary> <command...>
_zshrc_cached_source() {
  local name=$1 bin=${commands[$2]:A}
  shift 2
  [[ -n $bin ]] || return 1
  local cache="$_zshrc_cache_dir/$name.zsh" stamp
  [[ -r $cache ]] && read -r stamp < "$cache"
  if [[ $stamp != "# $bin" || $bin -nt $cache ]]; then
    mkdir -p "$_zshrc_cache_dir"
    if { print -r -- "# $bin"; "$@" } >| "$cache.$$" 2>/dev/null; then
      mv -f "$cache.$$" "$cache"
    else
      rm -f "$cache.$$"
    fi
  fi
  [[ -r $cache ]] && source "$cache"
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

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
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Native Autocomplete
################################

# Remap TAB to native completion
bindkey '^I' expand-or-complete

# Autojump - added from brew install info
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh


############
# Homebrew #
############

export PATH="/opt/homebrew/bin:$PATH"

# Allow comments in scripts
# Makes hash char a signal for comments in scripts
setopt interactivecomments

#################################
## Jenv			       ##
#################################
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# `jenv init -` costs ~0.3s, so its output is cached. The cached copy leaves out
# `jenv refresh-plugins` (only needed when jenv itself changes, so it runs when
# the cache is rebuilt) and runs `jenv rehash` in the background.
_zshrc_jenv_init() {
  command jenv refresh-plugins >/dev/null
  command jenv init - --no-rehash | grep -v '^jenv refresh-plugins$'
}
if (( $+commands[jenv] )); then
  _zshrc_cached_source jenv-init jenv _zshrc_jenv_init
  command jenv rehash &>/dev/null &!
fi

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

# Angular - Load Angular CLI autocompletion.
# Cached, since `ng completion script` starts Node (~0.3s).
(( $+commands[ng] )) && _zshrc_cached_source ng-completion ng env SHELL=/bin/zsh ng completion script

# Dotnet tools
export PATH="$PATH:/Users/aas/.dotnet/tools"

##################################
## Aliases                     ##
##################################

# opencode without plugins (no omo): stock build agent on Sonnet, small context
alias ocl='OPENCODE_PURE=1 opencode --model github-copilot/claude-sonnet-5'


##################################
## Zsh Options                 ##
##################################

setopt AUTO_CD

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  # Load nvm without activating a version: nvm's own `nvm use default` on
  # startup costs ~1s. Instead put the default version on PATH here, the same
  # way `nvm use` does (PATH, MANPATH, NVM_BIN, NVM_INC).
  \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
  () {
    # A version already on PATH (e.g. inherited from a parent shell) stays,
    # as with plain nvm.
    [[ -n ${path[(r)$NVM_DIR/versions/node/*/bin]} ]] && return
    local alias_default
    local -a dirs
    [[ -r $NVM_DIR/alias/default ]] && alias_default=$(<"$NVM_DIR/alias/default")
    # Only plain version aliases ("22", "v22.23") are resolved here
    [[ $alias_default =~ '^v?[0-9]+(\.[0-9]+)*$' ]] &&
      dirs=( "$NVM_DIR"/versions/node/v${alias_default#v}(|.*)(N/nOn) )
    if (( ! $#dirs )); then
      nvm_auto use  # anything else (lts/*, node, .nvmrc): let nvm resolve it
      return
    fi
    export PATH="$dirs[1]/bin:$PATH"
    # nvm only keeps a MANPATH change when MANPATH was already set
    [[ -n $MANPATH ]] && export MANPATH="$dirs[1]/share/man:$MANPATH"
    export NVM_BIN="$dirs[1]/bin" NVM_INC="$dirs[1]/include/node"
  }
fi
# nvm's bash_completion runs a full compinit when none is loaded yet, which
# costs ~0.35s and is redundant: zsh-autocomplete runs compinit itself. Marking
# compinit as autoloaded makes nvm skip that and only register its completion.
autoload -Uz compinit
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
