# Personal install script & dotfiles for setup

## Programs

| Program               | Web link                                      |
| --------------------- | --------------------------------------------- |
| Operating system      | [Debian 11 - Bullseye](https://www.debian.org/releases/bullseye/) |
| Shell                 | [ZSH](https://www.zsh.org/)                   |
| Editor                | [NvChad](https://github.com/NvChad/NvChad)    |
| Terminal emulator     | [Kitty](https://github.com/kovidgoyal/kitty)  |
| --------------------- | --------------------------------------------- |
| Window manager        | [Bspwm](https://github.com/baskerville/bspwm) |
| Compositor            | [Picom](https://github.com/yshui/picom)       |
| Hotkey daemon         | [Sxhkd](https://github.com/baskerville/sxhkd) |
| Colour scheme         | [Catppuccin](https://github.com/catppuccin/catppuccin) |
| --------------------- | --------------------------------------------- |
| Browser               | [Firefox ESR](https://www.mozilla.org/en-US/firefox/new/) |
| Music player          | [Spotify](https://www.spotify.com/)           |
| --------------------- | --------------------------------------------- |


## TODO

- use docker & it's [bind mounts](https://docs.docker.com/storage/bind-mounts/) to containerise only the build / packages for a language (eg: postgresDB)
   - write a script to do this properly
- install:
   - a `rm` drop in replacement
- add a script to set default tty prompt for user (ie, don't type user on startup)
- finish off polybar config
   - 12 hour time
   - sleep, lock
   - shutdown & reboot
   - audio output swap
- finish ROFI config

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
- chsh

Note: these applications should be present in base Debian 11

### Run

1. Install Debian 11

Suggestions:
- Installing a minimal version:
   - no X server
   - no desktop environment (including unchecking `Debian destop environment` + `GNOME`)
   - no user (except root) (when prompted, click `Go Back` twice, and skip the user setup steps)

2. ```shell
   wget -qO - https://raw.githubusercontent.com/G-Rowell/dotfiles/main/.config/dotfiles/install.sh | bash
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
