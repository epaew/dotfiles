### .zshenv write by maeda ###
# for debug/profiling
# zmodload zsh/zprof


##--------------------------------------------------#
## *PATH configuration
typeset -U PATH path
typeset -U FPATH fpath
typeset -U MANPATH manpath

if [[ $OSTYPE =~ 'darwin.*' ]]; then
    setopt no_global_rcs
    path=($(cat /etc/paths))
    path=(
      $(find /etc/paths.d -type f | xargs cat)
      $path
    )
elif [[ $(uname -r) =~ '.*Microsoft' ]]; then
    # https://github.com/microsoft/WSL/issues/352
    umask 022
fi

# xenv
envs=("rbenv" "pyenv" "nodenv")
for xenv in $envs; do
    path=(
        $HOME/.${xenv}/shims
        $path
    )

    # macOS向きに `no_global_rcs` を設定してるので、init 実行済みかどうかにかかわらず実行する
    if ( which $xenv &>/dev/null ); then
      eval "$($xenv init -)"
      export ${xenv:u}_ROOT=$($xenv root)
    fi
done

path=(
    $HOME/.local/bin
    $HOME/bin
    /opt/homebrew/opt/coreutils/libexec/gnubin
    /usr/local/opt/coreutils/libexec/gnubin
    /snap/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/local/sbin
    $path
)
fpath=(
    $ZDOTDIR/functions
    $HOME/.config/zsh/functions
    $HOME/.zsh-completions/src
    $fpath
)
manpath=(
    /usr/local/opt/coreutils/libexec/gnuman
    $manpath
)
# remove non-exist dirs
# https://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
path=(${^path}(N-/^W))
fpath=(${^fpath}(N-/^W))
manpath=(${^manpath}(N-/^W))

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
eval $(brew shellenv)
export HOMEBREW_NO_ANALYTICS=1

# fzf
export FZF_DEFAULT_OPTS="--height=15 --inline-info --reverse --tabstop=2"
export FZF_COMPLETION_TRIGGER="**"

# Ubuntu
export skip_global_compinit=1

##--------------------------------------------------#
## compile zshenv if file was changed
autoload -Uz zcompile
zcompile $ZDOTDIR/.zshenv
