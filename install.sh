#!/bin/bash

# Detect which package manager to use to install the software

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        pkgmgr=${osInfo[$f]}
        break
    fi
done

# Find the path to this script, in order to create the symlinks and
# other stuff

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

# Install the apps requuired for my setup
cat "$SCRIPTPATH/apps" | while read app
do
    eval "${pkgmgr} install -y {$app}"
done

# Create symlinks to config files and folders

ln -s "$SCRIPTPATH/dotconfig" "~/.config"
ln -s "$SCRIPTPATH/dotvim" "~/.vim"
ln -s "$SCRIPTPATH/dotipython" "~/.ipython"
ln -s "$SCRIPTPATH/doturxvt" "~/.urxvt"

# Foreach dotfile in ./dotfiles, associate with the proper filename
for dotfile in $(find "$SCRIPTPATH/dotfiles/" -type f)
do
    ln -s $dotfile "~/$(basename $dotfile | sed -e 's/dot/\./g')"
done

# install python packages

sudo pip3 install -r py_modules.txt
