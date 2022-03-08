# minimal path settings
typeset -U PATH path
path=(
    /opt/homebrew/bin # homebrew bin path
    /usr/local/bin    # homebrew bin path: old
    $path
)
export ZDOTDIR=$HOME/dotfiles/zsh

if [[ -n $SSH_CONNECTION ]]; then
    # Start terminal normally
    source $ZDOTDIR/.zshenv
else
    # initialize tmux session
    IDs=$(tmux list-sessions 2>/dev/null)
    if [[ ! -n $IDs ]]; then
        tmux new-session
        exit
    else
        create_new_session="Create New Session"
        opts="${create_new_session}:\n$IDs"
        SESSION_ID=$(echo $opts | fzf | cut -d: -f1)
        if [[ "$SESSION_ID" == "${create_new_session}" ]]; then
            tmux new-session
            exit
        elif [[ -n "$SESSION_ID" ]]; then
            tmux attach-session -t "$SESSION_ID"
            exit
        fi
        # Start terminal normally
        source $ZDOTDIR/.zshenv
    fi
fi
