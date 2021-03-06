#!/bin/bash
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
#        AUTHOR: Marco Filippone
#       CREATED: 06/22/2020 00:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

make_backup() {
  DIR=$(dirname "$1")
  test ! -e $1 && mkdir $DIR
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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm  # package manager

# Vim
## Colors
VIM_COLORS_PATH=~/.vim/colors
test ! -d $VIM_COLORS_PATH && mkdir $VIM_COLORS_PATH
cp $SCRIPT_PATH/vim/colors/* $VIM_COLORS_PATH
## .vimrc
VIM_PATH=~/.vimrc
make_backup $VIM_PATH
ln -s ${SCRIPT_PATH}/vim/.vimrc ${VIM_PATH}

# Neovim
## .vimrc
NEOVIM_PATH=~/.config/nvim/init.vim
make_backup $NEOVIM_PATH
ln -s ${SCRIPT_PATH}/neovim/init.vim ${NEOVIM_PATH}


## dependencies
### airline
sudo apt-get install powerline
sudo apt-get install fonts-powerline
### vim jedi
sudo apt-get install curl vim exuberant-ctags git ack-grep
# pip install pep8 flake8 pyflakes isort yapf
### autopep8
# pip install autopep8
### vim airline
sudo apt-get install pandoc


# Install nodejs
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs


# Install sdkman, java and sbt
curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.10.hs-adpt
sdk install sbt

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tfenv & terragrunt
brew install tfenv
