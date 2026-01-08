#!/bin/zsh

# Include local bin folder
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

# Default programs:
export TERMINAL="kitty"
export PAGER="less"
export EDITOR="vim"
export visual="vim"
export BROWSER="firefox"

export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=Hyprland

export CLASSPATH=/home/growell/ProgrammingCoursework/cs3131/

# ~/ Clean-up:
#export XDG_CONFIG_HOME="$HOME/.config"
#export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CACHE_HOME="$HOME/.cache"
#export XINITRC="$XDG_CONFIG_HOME/x11/xinitrc"
#
#export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
#
#export KDEHOME="$XDG_CONFIG_HOME/kde"
#export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
#export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
#export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export LESSHISTFILE="-"
#
# export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# export TEXMFHOME="$XDG_DATA_HOME/texmf"

# ########################################################
# Nothing placed below here please!
# ########################################################
# Start graphical X server if not already running
#[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx #"$XINITRC"
[ `tty` = "/dev/tty1" ] && ! pidof -S Hyprland >/dev/null 2>&1 && start-hyprland
