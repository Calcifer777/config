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
echo Script path: $SCRIPT_PATH

# Tmux
TMUX_PATH=~/.tmux.conf
test -e $TMUX_PATH && mv $TMUX_PATH $TMUX_PATH.backup 
echo "ln -l ${SCRIPT_PATH}/tmux/.tmux.conf ${TMUX_PATH}"
ln -s ${SCRIPT_PATH}/tmux/.tmux.conf ${TMUX_PATH}

# Vim
VIM_PATH=.vim
VIM_COLORS_PATH=${VIM_PATH}/colors
## Colors
test -d $VIM_COLORS_PATH && mkdir $VIM_COLORS_PATH
cp $SCRIPT_PATH/vim/colors/* $VIM_COLORS_PATH


