### .zshenv write by maeda ###
# initialize tmux session

# minimal path settings
typeset -U PATH path
path=(
    $HOME/.cache/dein/repos/github.com/junegunn/fzf/bin # fzf
    /usr/local/bin # tmux via homebrew
    $path
)

IDs=$(tmux list-sessions 2>/dev/null)
if [[ ! -n $IDs ]]; then
  tmux new-session
  exit
else
  create_new_session="Create New Session"
  opts="${create_new_session}:\n$IDs"
  ID=$(echo $opts | fzf | cut -d: -f1)
  if [[ "$ID" == "${create_new_session}" ]]; then
    tmux new-session
    exit
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
    exit
  else
    # Start terminal normally
    export ZDOTDIR=$HOME/dotfiles/zsh
    source $ZDOTDIR/.zshenv
  fi
fi
