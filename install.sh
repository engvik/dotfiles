#!/bin/bash

echo "[DOTFILES] Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"
SUBLIME="Preferences.sublime-settings"
VIMSCRIPTS="vimscripts/ftdetect/ vimscripts/syntax/"

mkdir -p ~/.dotfiles-backup

# Copy all the files:
echo "[DOTFILES] Copying config files."
for FILE in ${FILES}
do
	mv ~/${FILE} ~/.dotfiles-backup/
	cp ${FILE} ~/
done

# Set up vim directories:
echo "[DOTFILES] Setting up ~/.vim directories."
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

# Installing pathogen:
echo "[DOTFILES] Installing pathogen."
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Fetching and installing VIM-scripts using pathogen:
echo "[DOTFILES] Fetching and installing VIM-scripts using pathogen."
git clone --recursive https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim
git clone https://github.com/moll/vim-node.git ~/.vim/bundle/node

# Copy VIM-scripts:
echo "[DOTFILES] Manually installing VIM-scripts."
for SCRIPT in ${VIMSCRIPTS}
do
	cp -r ${VIMSCRIPTS} ~/.vim/
done

# Copy Sublime config.
echo "[DOTFILES] Copying Sublime config."
cp ${SUBLIME} ~/.config/sublime-text-3/Packages/User

# Install Sublime packages.
echo "[DOTFILES] Installing Sublime packages."
curl -Sso ~/.config/sublime-text-3/Installed\ Packages/ \
    https://sublime.wbond.net/Package%20Control.sublime-package
# git clone https://github.com/jisaacks/GitGutter.git ~/.config/sublime-text-3/Packages/


echo "[DOTFILES] Finished!"
