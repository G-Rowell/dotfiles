# ZSH, non-zsh environment file
# Fix some java applications trying to create sub-windows
export _JAVA_AWT_WM_NONREPARENTING=1

# export QT_STYLE_OVERRIDE=kvantum
#Mozilla 
export MOZ_USE_XINPUT2="1"	# Mozilla smooth scrolling/touchpads.

# Dotfile command to say we are on a laptop
export GROWELL_DOTFILES="laptop"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
