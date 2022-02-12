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

### Downloading the rest of the repo
########################################################
logP "git" "download the rest of the repo"
function dotfiles {
   /usr/bin/git --git-dir=$DOTFILES_DIR/.git/ --work-tree=$HOME_DIR $@
}
# TODO evaluate the below
# mkdir -p .config-backup
# dotfiles checkout
# if [ $? = 0 ]; then
#   echo "Checked out config.";
# else
#     echo "Backing up pre-existing dot files.";
#     dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
# fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
# Below is probably not needed, due to above setting
# dotfiles config core.excludesfile .config/dotfiles/gitignore

### Install setup
########################################################
logP "install" "add nonfree contrib to /etc/apt/sources.list"

logP "install" "installing core packages"
sed 's/#.*//' "$DOTFILES_DIR/package-list-core.txt" | xargs apt-get install -y

logP "install" "installing main packages"
sed 's/#.*//' "$DOTFILES_DIR/package-list-main.txt" | xargs apt-get install -y

### User setup
########################################################
logP "user setup" "creating user"
adduser growell sudo
logP "user setup" "adding user to privileged group"
sudo usermod -aG sudo growell
logP "user setup" "changing default shell to zsh"
chsh -s /bin/zsh growell >/dev/null 2>&1

### Script cleanup
########################################################
# rm $HOME_DIR/install.sh
# config update-index --assume-unchanged $HOME_DIR/install.sh
# rm $HOME_DIR/LICENSE
# config update-index --assume-unchanged $HOME_DIR/LICENSE
# rm $HOME_DIR/README.md
# config update-index --assume-unchanged $HOME_DIR/README.md
