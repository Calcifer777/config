#!/bin/bash - 
#===============================================================================
#
#          FILE: init.sh
# 
#         USAGE: ./init.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Marco Filippone, 
#  ORGANIZATION: 
#       CREATED: 06/22/2020 00:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

make_backup() { 
  test -e $1 && mv $1 $1.backup 
}

# Ranger
RANGER_PATH=~/.config/ranger/rifle.conf
make_backup $RANGER_PATH
ln -s ${SCRIPT_PATH}/ranger/rifle.conf ${RANGER_PATH}

# Tmux
TMUX_PATH=~/.tmux.conf
make_backup $TMUX_PATH
ln -s ${SCRIPT_PATH}/tmux/.tmux.conf ${TMUX_PATH}

# Vim
## Colors
VIM_COLORS_PATH=~/.vim/colors
test ! -d $VIM_COLORS_PATH && mkdir $VIM_COLORS_PATH
cp $SCRIPT_PATH/vim/colors/* $VIM_COLORS_PATH
## .vimrc
VIM_PATH=~/.vimrc
make_backup $VIM_PATH
ln -s ${SCRIPT_PATH}/vim/.vimrc ${VIM_PATH}
## dependencies
### vim jedi
sudo apt-get install curl vim exuberant-ctags git ack-grep
pip install pep8 flake8 pyflakes isort yapf
### autopep8
pip install autopep8




