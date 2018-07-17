### .zshenv write by maeda ###
export ZDOTDIR="$HOME/dotfiles/zsh"

##--------------------------------------------------#
## *PATH configuration
typeset -U PATH path
typeset -U FPATH fpath
typeset -U MANPATH manpath

if [[ $OSTYPE =~ 'darwin*' ]]; then
    setopt no_global_rcs
    path=($(cat /etc/paths.d/* /etc/paths))
fi

path=(
    $HOME/.cache/dein/repos/github.com/junegunn/fzf/bin
    $HOME/.rbenv/bin
    $HOME/.pyenv/bin
    /usr/local/opt/coreutils/libexec/gnubin
    /usr/texbin
    $HOME/.linuxbrew/bin
    /snap/bin
    $path
)
fpath=(
    $ZDOTDIR/functions
    $HOME/.autojump/functions
    $HOME/.config/zsh/functions
    $HOME/.zsh-completions/src
    $fpath
)
manpath=(
    /usr/local/opt/coreutils/libexec/gnuman
    $HOME/.linuxbrew/share/man
    $manpath
)
# remove non-exist dirs
# https://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
path=(${^path}(N-/^W))
fpath=(${^fpath}(N-/^W))
manpath=(${^manpath}(N-/^W))

# Homebrew
if [[ $OSTYPE =~ 'linux*' ]]; then
    export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
    export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
fi

# (rb|py)env
which rbenv &>/dev/null && [[ ! $(type rbenv) =~ "shell function" ]] && eval "$(rbenv init -)"
which pyenv &>/dev/null && [[ ! $(type pyenv) =~ "shell function" ]] && eval "$(pyenv init -)"

# autojump
[[ -f ~/.autojump/etc/profile.d/autojump.sh ]] &&\
    source ~/.autojump/etc/profile.d/autojump.sh

typeset -xTU SUDO_PATH sudo_path ':'
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))


##--------------------------------------------------##
## Environment variable configuration
export LANG=C
if [[ $UID -ne 0 && -n $(locale -a | grep -iE "ja_JP\.UTF-?8") ]]; then
    export LANG=ja_JP.UTF-8
fi

if ( which nvim >/dev/null ); then
    export EDITOR=nvim
    export TERM="screen-256color"
elif ( which vim >/dev/null ); then
    export EDITOR=vim
    export TERM="screen-256color"
else
    export EDITOR=vi
fi
export PAGER=less

# remove "/" from $WORDCHARS
# see below
# http://zsh.sourceforge.net/Guide/zshguide04.html
# 4.3.4: Words, regions and marks
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# (rb|py)env
if ( which rbenv >/dev/null ); then
    export RBENV_ROOT=$(rbenv root)
fi
if ( which pyenv >/dev/null ); then
    export PYENV_ROOT=$(pyenv root)
fi

# fzf
export FZF_DEFAULT_OPTS="--height=15 --inline-info --reverse --tabstop=2"
export FZF_COMPLETION_TRIGGER="**"


##--------------------------------------------------#
## compile zshenv if file was changed
autoload -Uz zcompile
zcompile $ZDOTDIR/.zshenv
