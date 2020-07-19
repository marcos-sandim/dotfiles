# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#export GTK_IM_MODULE=cedilla

export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_SCREEN_SCALE_FACTORS="1;1"

# Disable HiDPI Scaling - Fix font issues with Alacritty (https://github.com/jwilm/alacritty/issues/1501)
export WINIT_HIDPI_FACTOR=1
export WINIT_X11_SCALE_FACTOR=1

export TERMINAL=alacritty
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# export FZF_DEFAULT_COMMAND='fd --type f --no-ignore-vcs'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --no-ignore-vcs'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

export JQ_COLORS='0;39:0;39:0;39:0;39:0;32:1;39:1;39'
