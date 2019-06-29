#!/bin/sh -x

# create sym links
FILES=$(cat << __EOF__
.gemrc
.pryrc
.tigrc
.tmux.conf
.vimrc
.zshenv
__EOF__
)

for f in $FILES; do
    ln -sf ~/dotfiles/$f ~/$f
done

if [ "$(uname)" == 'Darwin' ]; then
    ln -s ~/dotfiles/Brewfile ~/Brewfile && brew bundle
elif [ "$(uname)" == 'Linux' ]; then
    ln -s ~/dotfiles/.conkyrc ~/.conkyrc
fi

# set git global config
(diff ~/.gitconfig ~/dotfiles/.gitconfig | grep '>' >/dev/null ) && \
    cat ~/dotfiles/.gitconfig >> ~/.gitconfig

# for nvim
[ -d ~/.config/nvim ] || \
    (mkdir -p ~/.config && ln -sf ~/dotfiles/config/nvim/ ~/.config/nvim)

# for ruby
[ -d ~/.rbenv/default-gems ] || \
    (mkdir -p ~/.rbenv && ln -sf ~/dotfiles/rbenv/default-gems ~/.rbenv/default-gems)

# install dependencies
[ -d ~/.tmux ] || \
    (mkdir -p ~/.tmux/plugins && \
    git clone --depth 1 https://github.com/tmux-plugins/tpm.git \
        ~/.tmux/plugins/tpm)

[ -d ~/.cache/dein/repos/github.com/Shougo ] || \
    (mkdir -p ~/.cache/dein/repos/github.com/Shougo && \
    git clone --depth 1 https://github.com/Shougo/dein.vim.git \
        ~/.cache/dein/repos/github.com/Shougo/dein.vim)

[ -d ~/.zsh-completions ] || \
    (git clone --depth 1 git://github.com/zsh-users/zsh-completions.git \
        ~/.zsh-completions)

[ -d ~/.config/zsh/functions ] || \
    (mkdir -p ~/.config/zsh/functions && \
    cd ~/.config/zsh/functions && \
    curl -LO \
        https://raw.github.com/git/git/master/contrib/completion/git-completion.bash \
        https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh -o _git
    )
