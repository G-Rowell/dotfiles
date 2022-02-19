#!/bin/bash
# Script to setup my Debian installation
########################################################
# Helper funcs & vars
########################################################
USER="growell"
HOME_DIR="/home/$USER"
DOTFILES_DIR="$HOME_DIR/.config/dotfiles"
AUTO_INSTALL="y"

# Tee stdout & stderr to the log file
exec >  >(tee -ia install.log)
exec 2> >(tee -ia install.log >&2)

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
}

check_user_approval() {
   if [[ "$AUTO_INSTALL" = "y" ]]
   then
      return 1
   else
      read -p "$1? [y/n] " RESPONSE
      [[ ! "$RESPONSE" = "y" ]] || return 1
      unset RESPONSE
   fi
}

install_core_pkgs() {
   apt update

   logP "install" "installing core packages"
   sed 's/#.*//' "$DOTFILES_DIR/package-list-core.txt" | apt-get install -y
}

install_custom_pkgs() {
   apt update

   logP "install" "installing custom packages"
   sed 's/#.*//' "$DOTFILES_DIR/package-list-custom.txt" | apt-get install -y
   
   ### Spotify install
   wget -O - https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
   echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
   apt update && apt install -y spotify-client
}

create_user() {
   logP "user setup" "creating user"
   useradd -M -G sudo -s /bin/zsh "$USER"
   passwd $USER

   logP "user setup" "modifying user group to allow certain privelleged commands"
   cp $DOTFILES_DIR/sudoers-growell /etc/sudoers.d/
}

font_install() {
   mkdir -p "$HOME_DIR/.local/share/fonts"
   ( cd $(mktemp -d); wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.zip; unzip SourceCodePro.zip; mv "Sauce Code Pro Nerd Font Complete Mono.ttf" "$HOME_DIR/.local/share/fonts/")

   fc-cache -f
}

neovim_install() {
   mkdir "$HOME_DIR/.local/bin"
   wget -P "$HOME_DIR/.local/bin/" https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
   chmod u+x "$HOME_DIR/.local/bin/nvim.appimage"
   update-alternatives --install /usr/bin/ex ex "$HOME_DIR/.local/bin/nvim.appimage" 110
   update-alternatives --install /usr/bin/vi vi "$HOME_DIR/.local/bin/nvim.appimage" 110
   update-alternatives --install /usr/bin/vim vim "$HOME_DIR/.local/bin/nvim.appimage" 110
   update-alternatives --install /usr/bin/vimdiff vimdiff "$HOME_DIR/.local/bin/nvim.appimage" 110
   update-alternatives --install /usr/bin/view view "$HOME_DIR/.local/bin/nvim.appimage" 110

   # TODO: consider sub-modules for git?
   git clone https://github.com/G-Rowell/NvChad "$HOME_DIR/.config/nvim"
   # "$HOME_DIR/.local/bin/nvim.appimage" --headless -c 'autocmd User VimEnter quitall'
   # "$HOME_DIR/.local/bin/nvim.appimage" --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

}

########################################################
# Main program
########################################################
### Start script
########################################################
logP "start" "starting the script!"

### Git setup
########################################################
apt install -y git
git clone --bare https://github.com/G-Rowell/dotfiles.git /home/growell/.config/dotfiles/.git
git --git-dir="$DOTFILES_DIR/.git/" --work-tree="$HOME_DIR" checkout
git --git-dir="$DOTFILES_DIR/.git/" --work-tree="$HOME_DIR" config status.showUntrackedFiles no

### Install packages
########################################################
# logP "install" "add nonfree contrib to /etc/apt/sources.list"
# sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list
install_core_pkgs

check_user_approval "install custom packages" || install_custom_pkgs

### User setup
########################################################
check_user_approval "create & setup user" || create_user

### Font install
########################################################
check_user_approval "install nerd font" || font_install

### NeoVim setup
########################################################
check_user_approval "install neovim" || neovim_install

### Script cleanup
########################################################
logP "script cleanup" "removing git symbollic links from $HOME_DIR"
rm "$HOME_DIR/install.sh"
git --git-dir="$DOTFILES_DIR/.git/" --work-tree="$HOME_DIR" update-index --assume-unchanged "$HOME_DIR/install.sh"
rm "$HOME_DIR/LICENCE"
git --git-dir="$DOTFILES_DIR/.git/" --work-tree="$HOME_DIR" update-index --assume-unchanged "$HOME_DIR/LICENCE"
rm "$HOME_DIR/README.md"
git --git-dir="$DOTFILES_DIR/.git/" --work-tree="$HOME_DIR" update-index --assume-unchanged "$HOME_DIR/README.md"

logP "script cleanup" "'chown'ing the user dir"
chown "$USER:$USER" --preserve-root -R "$HOME_DIR"
