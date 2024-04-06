#!/usr/bin/env bash

set -e

ROOT_DIR=${HOME}
#
# Clean up
# rm -rf libevent-2.1.12-stable.tar.gz
# rm -rf ncurses-6.2.tar.gz
# rm -rf tmux-3.2-rc4.tar.gz

sudo rm -rf tmux-3.4
wget "https://github.com/tmux/tmux/releases/download/3.4/tmux-3.4.tar.gz"
# cp -r "./libevent-2.1.12-stable.tar.gz" "./ncurses-6.2.tar.gz" "./tmux-3.2-rc4.tar.gz" ${ROOT_DIR}
#
# cd ${ROOT_DIR}

# install yacc and libevent for compile

sudo tar xvf "tmux-3.4.tar.gz"

# compile
sudo apt-get install yacc 
sudo apt-get install libevent-dev

sudo configure && sudo make 

sudo mv ./tmux  /usr/bin/tmux 

# Install libevent
# -- echo "[SUCCESS] ${ROOT_DIR}/.local/bin/tmux is now available"
