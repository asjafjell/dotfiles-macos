#################################
## Shell                       ##
#################################

# Make sure Homebrew is in path. HOMEBREW_PREFIX avoids calling `brew --prefix`
# (about 40ms each) during startup.
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

# Point to .dotfiles-macos repo
export DOTFILES=~/.dotfiles-macos

# Once a day, flash a reminder about the shell tricks in the README.
# Kept above the Powerlevel10k instant prompt so printing here is allowed.
() {
  setopt local_options extended_glob
  local stamp=${XDG_CACHE_HOME:-$HOME/.cache}/zsh-tips-shown
  [[ -n $stamp(#qN.mh-24) ]] && return
  mkdir -p ${stamp:h} && : >| $stamp
  print -P "%K{magenta}%F{white}%B ⚡ SHELL TRICKS %b%f%k %F{magenta}Ctrl+R%f history · %F{magenta}Ctrl+T%f files · %F{magenta}Alt+C%f folders · %F{magenta}z%f jump  %F{8}→ run%f %Btips%b %F{8}for the rest%f"
}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

if [[ $TERMINAL_EMULATOR == "JetBrains-JediTerm" ]]; then
 [[ ! -f $DOTFILES/zsh/.p10k-intellij.zsh ]] || source $DOTFILES/zsh/.p10k-intellij.zsh
else
 [[ ! -f $DOTFILES/zsh/.p10k-ghostty.zsh ]] || source $DOTFILES/zsh/.p10k-ghostty.zsh
fi

#################################
## AUTOCOMPLETE SETUP          ##
#################################

# Native Zsh completion. Must run before fzf-tab and anything calling compdef.
# Docs here: https://zsh.sourceforge.io/Doc/Release/Options.html
# Rebuilding the completion cache takes ~300ms, so only do it once a day.
autoload -Uz compinit
() {
  setopt local_options extended_glob
  if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) || ! -s ${ZDOTDIR:-$HOME}/.zcompdump ]]; then
    compinit
  else
    compinit -C
  fi
}
setopt complete_in_word   # insert common prefix on first TAB

# fzf: Ctrl+T pastes a file path, Alt+C cd's into a folder.
# Loaded before fzf-tab so fzf-tab owns TAB.
source <(fzf --zsh)

# fzf-tab
################################
# - Is installed via brew (see brewfile)
# - Turns the TAB completion menu into a fuzzy searchable list with previews
source $HOMEBREW_PREFIX/share/fzf-tab/fzf-tab.zsh
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*:descriptions' format '[%d]'         # lets fzf-tab group results
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Zsh Autosuggestions
################################
# - Is installed via brew (see brewfile)
# - Gives the 'greyed out' suggestions when typing
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#################################
## History and navigation      ##
#################################

# atuin: searchable shell history on Ctrl+R. Loaded after fzf so it owns Ctrl+R.
# The up arrow keeps its normal behaviour.
eval "$(atuin init zsh --disable-up-arrow)"

# zoxide: `z <part of path>` jumps to the best match, `zi` picks from a list
eval "$(zoxide init zsh)"


############
# Homebrew #
############

# Allow comments in scripts
# Makes hash char a signal for comments in scripts
setopt interactivecomments

#################################
## Jenv			       ##
#################################
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

if (( $+commands[jenv] )); then
  eval "$(jenv init -)"
  # The export plugin sets JAVA_HOME before every prompt (~50ms each time).
  # Only do it when changing directory or after running jenv.
  precmd_functions=(${precmd_functions:#_jenv_export_hook})
  chpwd_functions+=(_jenv_export_hook)
  functions[_jenv_wrapped]=$functions[jenv]
  # Only after commands that change the version: the hook itself runs
  # `jenv javahome`, so refreshing after every jenv call would recurse.
  jenv() {
    _jenv_wrapped "$@"; local ret=$?
    case $1 in shell|local|global) _jenv_export_hook ;; esac
    return $ret
  }
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

# Dotnet tools
export PATH="$PATH:/Users/aas/.dotnet/tools"

##################################
## Aliases                     ##
##################################

# eza and bat as nicer ls and cat. bat behaves like plain cat when piped.
alias ls='eza --group-directories-first'
alias ll='eza -la --git --group-directories-first'
alias tree='eza --tree'
alias cat='bat --paging=never'

# Print the "Shell tricks" section of the README
tips() {
  awk '/^## ⚡ Shell tricks/{f=1} f&&/^## /&&!/Shell tricks/{exit} f' $DOTFILES/README.md |
    bat -l md --paging=never --style=plain
}
export BAT_THEME=ansi   # follow the terminal's colours (Flexoki Light)

# opencode without plugins (no omo): stock build agent on Sonnet, small context
alias ocl='OPENCODE_PURE=1 opencode --model github-copilot/claude-sonnet-5'


##################################
## Zsh Options                 ##
##################################

setopt AUTO_CD

# nvm takes ~0.8s to load, so put the default Node on PATH directly and only
# load nvm the first time `nvm` is run.
export NVM_DIR="$HOME/.nvm"
_nvm_load() {
  unfunction nvm _nvm_load 2>/dev/null
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
nvm() { _nvm_load && nvm "$@" }
() {
  local default=$(<$NVM_DIR/alias/default 2>/dev/null)
  local -a found=($NVM_DIR/versions/node/v${default#v}*/bin(N/nOn))
  if [[ $default == [0-9]* && -n $found ]]; then
    export PATH="$found[1]:$PATH"
  elif [[ -s $NVM_DIR/nvm.sh ]]; then
    _nvm_load   # default is an alias like lts/*, let nvm resolve it
  fi
}

##################################
## SSH-key                      ##
##################################
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-ssh-agent.sock"

##################################
## Syntax highlighting          ##
##################################
# Must be sourced last so it can wrap every widget defined above.
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
