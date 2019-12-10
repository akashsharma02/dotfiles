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
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
source "/home/akashsharma/.fzf/shell/key-bindings.bash"
