setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
#unsetopt HIST_SAVE_NO_DUPS       # Write a duplicate event to the history file
HISTFILE=~/.zsh_history
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'


##############
#
# VI Mode!
#
##############
#bindkey -v
#export KEYTIMEOUT=1
#cursor_mode() {
#    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
#    cursor_block='\e[2 q'
#    cursor_beam='\e[6 q'
#
#    function zle-keymap-select {
#        if [[ ${KEYMAP} == vicmd ]] ||
#            [[ $1 = 'block' ]]; then
#            echo -ne $cursor_block
#        elif [[ ${KEYMAP} == main ]] ||
#            [[ ${KEYMAP} == viins ]] ||
#            [[ ${KEYMAP} = '' ]] ||
#            [[ $1 = 'beam' ]]; then
#            echo -ne $cursor_beam
#        fi
#    }
#
#    zle-line-init() {
#        echo -ne $cursor_beam
#    }
#
#    zle -N zle-keymap-select
#    zle -N zle-line-init
#}
#
#cursor_mode
#
#autoload -Uz edit-command-line
#zle -N edit-command-line
#bindkey -M vicmd v edit-command-line

  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# source ./gambit.zsh

# Load more completions
fpath=($DOTFILES/zsh/plugins/zsh-completions/src $fpath)

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/anton/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/anton/.fzf/bin"
fi

source <(fzf --zsh)

# Only work with the Zsh function vman
# See $DOTFILES/zsh/scripts.zsh
compdef vman="man"

# +---------+
# | Options |
# +---------+

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification


zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

############# 
#
# line styling
#
############# 
#autoload -U compinit; compinit

# Purification
# by Matthieu Cneude
# https://github.com/Phantas0s/purification

# Based on:

# Purity
# by Kevin Lanni
# https://github.com/therealklanni/purity
# MIT License

# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

# Display git status
# TODO to refactor with switch / using someting else than grep
# Might be faster using ripgrep too
git_prompt_status() {
  local INDEX STATUS

#  INDEX=$(command git status --porcelain -b 2> /dev/null)
#
#  STATUS=""
#
#  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
#  elif $(echo "$INDEX" | grep '^M  ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
#  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
#  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
#  elif $(echo "$INDEX" | grep '^MM ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
#  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
#  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
#  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
#  fi
#
#  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^## [^ ]\+ .*ahead' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^## [^ ]\+ .*behind' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
#  fi
#
#  if $(echo "$INDEX" | grep '^## [^ ]\+ .*diverged' &> /dev/null); then
#    STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
#  fi
#
#  if [[ ! -z "$STATUS" ]]; then
#    echo " [ $STATUS]"
#  fi
}


prompt_git_branch() {
    autoload -Uz vcs_info 
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    zstyle ':vcs_info:git:*' formats '%b'
}

prompt_git_info() {
    [ ! -z "$vcs_info_msg_0_" ] && echo "$ZSH_THEME_GIT_PROMPT_PREFIX%F{white}$vcs_info_msg_0_%f$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

prompt_purity_precmd() {
    # Pass a line before each prompt
    print -P ''
}

prompt_purification_setup() {
    # Display git branch

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd prompt_purity_precmd

    ZSH_THEME_GIT_PROMPT_PREFIX=" %F{red}λ%f:"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    ZSH_THEME_GIT_PROMPT_ADDED="%F{green}+%f "
    ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue}%f "
    ZSH_THEME_GIT_PROMPT_DELETED="%F{red}x%f "
    ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta}➜%f "
    ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow}═%f "
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{white}%f "
    ZSH_THEME_GIT_PROMPT_STASHED="%B%F{red}%f%b "
    ZSH_THEME_GIT_PROMPT_BEHIND="%B%F{red}%f%b "
    ZSH_THEME_GIT_PROMPT_AHEAD="%B%F{green}%f%b "

    prompt_git_branch
    RPROMPT='$(prompt_git_info) $(git_prompt_status)'
    PROMPT=$'%F{white}%~ %B%F{blue}>%f%b '
}

prompt_purification_setup

# wsl alias
alias pwsh="powershell.exe -c"

# zsh alias
alias ls="ls -la"
alias source="source ~/.zshrc"

# git alias
alias gca="git commit --amend --no-edit"
alias gcm="git commit -m"
alias gs="git status"
alias ga="git add"
alias gsh="git push"
alias gll="git pull"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
