#!/bin/bash
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.fzf.bash ~/.fzf.bash
ln -sf ~/dotfiles/nvim ~/.config/
ln -sf ~/dotfiles/.bashrc ~/.bashrc

# setup tmux plugin manager, if not yet installed
if [ -d "~/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

