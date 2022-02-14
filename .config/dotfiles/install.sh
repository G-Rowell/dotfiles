#!/bin/bash
# Script to setup my Debian installation
########################################################
# Helper funcs & vars
########################################################
USER="growell"
HOME_DIR="/home/growell"
DOTFILES_DIR="$HOME_DIR/.config/dotfiles"

# 2 args, category, specific action
logP() {
   log 36 "$1" "$2"
}

# 1 arg, error code
error() {
   log 31 'error' "$1"
}

# 3 args, colour, category, specific note
log() {
   echo -e "\e[0;$1m-- $2 | \e[0m$3"
   echo -e "\e[0;$1m-- $2 | \e[0m$3" >> $HOME_DIR/install.log
}


########################################################
# Main program
########################################################
### Start script
########################################################
logP "start" "starting the script!"


### Install setup
########################################################
# logP "install" "add nonfree contrib to /etc/apt/sources.list"
# sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list

logP "install" "installing core packages"
sed 's/#.*//' "$DOTFILES_DIR/package-list-core.txt" | xargs -- apt-get install -y --

logP "install" "installing main packages"
sed 's/#.*//' "$DOTFILES_DIR/package-list-main.txt" | xargs -- apt-get install -y --


### User setup
########################################################
logP "user setup" "creating user"
useradd -M -G sudo -s /bin/zsh "$USER"
# echo "$USER:$USER" | chpasswd
passwd $USER

logP "user setup" "modifying user group to allow certain privelleged commands"
cp $DOTFILES_DIR/sudoers-growell /etc/sudoers.d/

### Git setup
########################################################
/usr/bin/git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$HOME_DIR config status.showUntrackedFiles no
# Below is probably not needed, due to above setting
# dotfiles config core.excludesfile .config/dotfiles/gitignore


### Script cleanup
########################################################
logP "script cleanup" "removing git symbollic links from /home/growell/"
rm $HOME_DIR/install.sh
/usr/bin/git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$HOME_DIR update-index --assume-unchanged $HOME_DIR/install.sh
rm $HOME_DIR/LICENSE
/usr/bin/git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$HOME_DIR update-index --assume-unchanged $HOME_DIR/LICENSE
rm $HOME_DIR/README.md
/usr/bin/git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$HOME_DIR update-index --assume-unchanged $HOME_DIR/README.md

logP "script cleanup" "'chown'ing the user dir"
chown "growell:growell" --preserve-root -R /home/growell/
