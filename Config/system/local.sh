#!/usr/bin/env bash

# Localization Standartization parameters: function, directory pointers, path additions
# DEVICE: AllSeer (Desktop Linux System)

# HOME
export HOME=/home/atai

# Temporary Directory
export TMP=/tmp

# etc
export ETC=/etc

# usr/bin
export SYSTEM_BIN=/usr/bin

# Drive Mounts
export PHONE=/run/user/1000/gvfs/mtp:host=SAMSUNG_SAMSUNG_Android_R58MC0KYREJ/Phone/Home
export HOMEW=/media/atai/Windows/Windows/Users/ataya/Home

# Useful System Directories
export APPS=/usr/share/applications
export LAPPS=~/.local/share/applications

# Specific System Path Additions
export PATH=$PATH:/snap/bin

# exa pointer (to use in wrapper function)
function _exa() {
    /usr/local/bin/exa $@
}

# ls pointer (to use in wrapper funciton)
function _ls() {
    /usr/bin/ls --color=auto $@
}

# sudo or sudo equivalent pointer (for cygwin, android, etc.)
function sudo() {
    /usr/bin/sudo $@
}

# xdg-open or equivalent pointer
function open() {
    xdg-open "$@"
}

# Open a url link
function url() {
    addr=$(echo $@ | sed 's/ /%20/g')
    echo Opening $addr
    google-chrome "$addr"
}

# Update local configs from github gists
function update-local() {
    wget -O $BIN/Config/system/local.fish https://gist.githubusercontent.com/TheAllSeeing/a37ad2da8d06dbd8aca5ad2d04232b53/raw/c95f2ea49e690fac31cf0f1c3a2bb902ad0787b8/local.fish
    wget -O $BIN/Config/system/local.py https://gist.github.com/TheAllSeeing/f1021dc01dc7636f00e456ae8b10e70e/raw/dccd67868482e924be62d0b6a8a5f7cd84890991/local.py
    wget -O $BIN/Config/system/local.sh https://gist.github.com/TheAllSeeing/f1021dc01dc7636f00e456ae8b10e70e/raw/dccd67868482e924be62d0b6a8a5f7cd84890991/local.sh
}

# System-Specific App Configurations
source /etc/profile.d/undistract-me.sh
eval "$(thefuck --alias)"
