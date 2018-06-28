### .zshrc write by maeda ###

##--------------------------------------------------##
## start tmux session
autoload -Uz tmux-init; tmux-init


##--------------------------------------------------##
## compile zshrc if file was changed
autoload -Uz zcompile
zcompile $ZDOTDIR/.zshrc


##--------------------------------------------------##
## login/logout behavior
watch="all"
setopt ignore_eof  # cannot logout by ^D


##--------------------------------------------------##
## alias configuration
setopt complete_aliases    # aliased ls needs if file/dir completion work
alias irb="pry"
alias vi="vim"

if ( which nvim >/dev/null ); then
    alias vim="nvim -o"
elif ( which vim >/dev/null ); then
    alias vim="vim -o"
else
    alias vim="vi"
fi

alias ls="ls --color=auto"
alias -g F="| fzf"
alias -g G="| grep"
alias -g L="|& less"       # "|&" means "2>&1 |", pipe both of stdout, stderr
alias -g T="|& tail -f"

if [[ $OSTYPE =~ 'linux*' ]]; then
    if ( which exo-open &>/dev/null ); then
        alias -g open=exo-open
    else
        alias -g open=xdg-open
    fi
    if [[ -n $DISPLAY ]] && ( which xsel &>/dev/null ); then
        alias -g pbcopy='xsel --clipboard --input'
    fi
fi


##--------------------------------------------------##
## prompt configration
autoload -Uz promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least
setopt prompt_percent
setopt transient_rprompt

# common prompt
promptinit
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
    prompt adam1 red
else
    prompt adam1
fi
RPROMPT="%(?.%F{green}.%F{red})[%*]%f"

if is-at-least 4.3.10; then
    # prompt configuration for svn and git
    setopt prompt_subst

    # variables
    vcs_base='%F{green}[%s-%b]%f'
    vcs_stage='%F{yellow}%u%c%f'
    vcs_action='%F{green}[%s-%b%F{red}<!%a>%f]%f'
    # svn
    zstyle ':vcs_info:*' enable git svn
    zstyle ':vcs_info:svn:*' formats ${vcs_base}
    zstyle ':vcs_info:svn:*' actionformats ${vcs_action}
    zstyle ':vcs_info:svn:*' branchformat '%b:r%r'
    # git
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats ${vcs_base}${vcs_stage}
    zstyle ':vcs_info:git:*' actionformats ${vcs_action}${vcs_stage}
    precmd () { LANG=en_US.UTF-8 vcs_info }
    RPROMPT='${vcs_info_msg_0_}'${RPROMPT}
fi


##--------------------------------------------------##
## Completion configuration
autoload -Uz compinit && compinit -u
zmodload zsh/complist

zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # in completion, a-z to A-Z
zstyle ':completion:*' use-cache true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' menu select          # select completion by cursor
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

setopt auto_list
setopt auto_menu
setopt complete_in_word
setopt extended_glob
setopt glob_complete
setopt globdots
setopt hist_expand
setopt list_packed
setopt list_types
setopt noautoremoveslash
setopt numeric_glob_sort


##--------------------------------------------------##
## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt hist_no_store
setopt inc_append_history
setopt hist_ignore_dups     # ignore duplication command history list
setopt hist_ignore_all_dups
setopt share_history        # share command history data
setopt hist_ignore_space     # ignore if contain space at top of line
setopt hist_reduce_blanks   # reduce space

setopt pushd_ignore_dups    # ignore duplication directory move history list

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end


##--------------------------------------------------##
## key bindings
bindkey -e
bindkey -r '^J'
bindkey -r '^O'
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey '^[[Z' reverse-menu-complete      # shift-Tab reverse completion
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end


##--------------------------------------------------##
## others
setopt auto_cd    # change direcory without cd command
setopt auto_pushd  # directory completion

setopt no_beep
setopt correct    # correct input word
#setopt dvorak    # command correction for dvorak user
setopt magic_equal_subst
setopt mark_dirs
setopt print_eight_bit
setopt auto_resume
setopt rm_star_wait

autoload -Uz replace-githooks
autoload -Uz zmv
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh # includes override key-binds
