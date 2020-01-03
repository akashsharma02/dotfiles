# Setup fzf
# ---------
if [[ ! "$PATH" == */home/akashsharma/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/akashsharma/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/akashsharma/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/akashsharma/.fzf/shell/key-bindings.bash"
export FZF_TMUX=1

