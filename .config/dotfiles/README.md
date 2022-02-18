# Personal install script & dotfiles for setup

## TODO

- use docker & it's [bind mounts](https://docs.docker.com/storage/bind-mounts/) to containerise only the build / packages for a language (eg: postgresDB)
   - write a script to do this properly
- install:
   - a `rm` drop in replacement
   - docker
- use wget & tar to avoid needing git right away, instead install git with install.sh

ZSH:

Add below to '/etc/zsh/zshenv' (causes zshenv settings to be global)
```shell
if [[ -z $XDG_CONFIG_HOME ]]
then
        export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z $ZDOTDIR ]]
then
        export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
fi
```

## Run the script

### Requirements

- bash
- wget
- sed
- xargs
- chsh
- git

Note: these applications should be present in base minimal install Debian 11 with the exception of `git` (installed as per below)

Be careful with below:

```shell
apt install -y git; git clone --bare https://github.com/G-Rowell/dotfiles.git /home/growell/.config/dotfiles/.git; /bin/bash /home/growell/install.sh
```

## What this script does

1. [Installs this list of packages](https://github.com/G-Rowell/dotfiles/blob/main/.config/dotfiles/package-list.txt)
2. Sets up the user, including:
   - giving special sudo permissions for various commands such as `apt`
3. Installs various dotfile configurations, notable ones include:
   - NeoVim
   - Kitty
   - Zsh
   - Bspwm + Picom + Sxhkd + Polybar
4. Installs various applications from third-party repos:
   - Spotify
   - NeoVim
   - Docker
   - A nerd-font (for special symbols)

## Acknowledgements

This was compiled together from various public dotfiles, tutorials and many forum posts across the internet. Thank you to all.

Including:

- [Luke Smith LARBS](https://github.com/LukeSmithxyz/LARBS/)
   
   Much of this repo has been taken or inspired from his, including bin scripts.

- [Atlasssian Git bare repo for Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)

- [Ulises Jeremias' dotfile generator (and rofi scripts)](https://github.com/ulises-jeremias/dotfiles)

- Rofi scripts:
   - [Niraj998 rofi scripts](https://github.com/niraj998/Rofi-Scripts)

## Minor Acknowledgements

- [Download a GitHub repo and extract locally](https://stackoverflow.com/a/8378458)

- [Use sed & xargs to run apt-get](https://www.monolune.com/installing-apt-packages-from-a-requirements-file/)
