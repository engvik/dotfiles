#!/bin/bash

echo "Installing dotfiles. Your old files WILL be overridden. Sorry. You can find a backup of your old files in ~/.dotfiles-backup"
FILES=".bash_prompt .bashrc .gitignore .vimrc .gitconfig"
VIMSCRIPTS="ftdetect/ syntax/"

mkdir -p ~/.dotfiles-backup

# Copy all the files:
for FILE in ${FILES}
do
	mv ~/${FILE} ~/.dotfiles-backup/
	cp ${FILE} ~/
done

# Copy VIM-scripts:
for SCRIPT in ${VIMSCRIPTS}
do
	cp -r ${VIMSCRIPTS} ~/.vim/
done

echo "Setting up ~/.vim directories"

# Set up vim directories and install Pathogen:
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/backups
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo

curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

echo "Finished!"
