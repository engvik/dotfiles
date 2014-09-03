#!/bin/bash

echo "[DOTFILES] Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"
VIMSCRIPTS="ftdetect/ syntax/"

mkdir -p ~/.dotfiles-backup

# Copy all the files:
echo "[DOTFILES] Copying config files."
for FILE in ${FILES}
do
	mv ~/${FILE} ~/.dotfiles-backup/
	cp ${FILE} ~/
done

# Set up vim directories and install Pathogen:
echo "[DOTFILES] Setting up ~/.vim directories."
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

# Installing pathogen.
echo "[DOTFILES] Installing pathogen."
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Fetching and installing VIM-scripts using pathogen.
echo "[DOTFILES] Fetching and installing VIM-scripts using pathogen."
cd ~/.vim/bundle/ && git clone --recursive https://github.com/davidhalter/jedi-vim.git

# Copy VIM-scripts.
echo "[DOTFILES] Manually installing VIM-scripts."
for SCRIPT in ${VIMSCRIPTS}
do
	cp -r ${VIMSCRIPTS} ~/.vim/
done

echo "Finished!"
