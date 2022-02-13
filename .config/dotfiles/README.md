# Personal install script & dotfiles for setup

## TODO

- use docker & it's [bind mounts](https://docs.docker.com/storage/bind-mounts/) to containerise only the build / packages for a language (eg: postgresDB)
   - write a script to do this properly
- install:
   - a `rm` drop in replacement
   - docker

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
apt install -y git; git clone --bare git@github.com:G-Rowell/dotfiles.git /home/growell/; /usr/bin/git --git-dir=/home/growell/.config/dotfiles/.git/ --work-tree=/home/growell checkout; /bin/bash /home/growell/install.sh
```

## Acknowledgements

This was compiled together from various public dotfiles, tutorials and many forum posts across the internet. Thank you to all.

Including:

- [Luke Smith LARBS](https://github.com/LukeSmithxyz/LARBS/)
   
   Much of this repo has been taken or inspired from his, including bin scripts.

- [Atlasssian Git bare repo for Dotfiles](https://www.atlassian.com/git/tutorials/dotfiles)

- [Ulises Jeremias' dotfile generator (and rofi scripts)](https://github.com/ulises-jeremias/dotfiles)

- Rofi scripts:
   - [Nirah998 rofi scripts](https://github.com/niraj998/Rofi-Scripts)

## Minor Acknowledgements

- [Download a GitHub repo and extract locally](https://stackoverflow.com/a/8378458)

- [Use sed & xargs to run apt-get](https://www.monolune.com/installing-apt-packages-from-a-requirements-file/)
