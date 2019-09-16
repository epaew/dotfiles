### .zshrc write by maeda ###

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
setopt complete_aliases # aliased ls needs if file/dir completion work

if ( which nvim >/dev/null ); then
    alias vim="nvim -o"
elif ( which vim >/dev/null ); then
    alias vim="vim -o"
else
    alias vim="vi"
fi

alias irb="pry"
alias ls="ls --color=auto"
alias vi="vim"
alias vihist="vim ~/.zsh_history"
alias -g F="| fzf"
alias -g G="| grep"
alias -g L="|& less"       # "|&" means "2>&1 |", pipe both of stdout, stderr
alias -g T="|& tail -f"

if [[ $OSTYPE =~ 'linux.*' ]]; then
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

# prompt init
promptinit && prompt adam1 "%(?.blue.red)"


##--------------------------------------------------##
## rprompt configuration for git
setopt prompt_subst

vcs_prefix='%F{green}[%s-%b%f'
vcs_action='%F{red}<!%a>%f'
vcs_suffix='%F{yellow}%u%c%f%F{green}]%f'

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "${vcs_prefix}${vcs_suffix}"
zstyle ':vcs_info:git:*' actionformats "${vcs_prefix}${vcs_action}${vcs_suffix}"
precmd () { LANG=en_US.UTF-8 vcs_info }
RPROMPT='${vcs_info_msg_0_}'


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

# for key bindings
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end


##--------------------------------------------------##
## key bindings
bindkey -e
bindkey -r '^J'
bindkey -r '^O'
bindkey -r '^[Q'
bindkey -r '^[q'
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey '^[[Z' reverse-menu-complete      # shift-Tab reverse completion
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end

autoload -Uz show_buffer_stack
zle -N show_buffer_stack
bindkey "^q" show_buffer_stack

##--------------------------------------------------##
## others
setopt auto_cd         # change direcory without cd command
setopt auto_pushd      # directory completion

setopt auto_resume
setopt correct         # correct input word
setopt magic_equal_subst
setopt mark_dirs
setopt no_beep
setopt no_flow_control # Disable output flow control via start/stop characters. (usually assigned to ^S/^Q)
setopt print_eight_bit
setopt rm_star_wait

autoload -Uz git
autoload -Uz set-tmux-bg
autoload -Uz ssh
autoload -Uz zmv
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh # includes override key-binds

# print debug/profiling information if zprof is enabled
(which zprof &>/dev/null && zprof) || true
