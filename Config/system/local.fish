#!/bin/env fish


# Localization Standartization parameters: function, directory pointers, path additions
# DEVICE: AllSeer (Desktop Linux System)

# HOME
set -x HOME /home/atai

# Temporary Directory
set -x TMP /tmp

# etc
set -x ETC /etc

# usr/bin
set -x SYSTEM_BIN /usr/bin

# Drive Mounts
set -x PHONE /run/user/1000/gvfs/mtp:host=SAMSUNG_SAMSUNG_Android_R58MC0KYREJ/Phone/Home
set -x HOMEW /media/atai/Windows/Windows/Users/ataya/Home

# Useful System Directories
set -x APPS /usr/share/applications
set -x LAPPS ~/.local/share/applications

# Specific System Path Additions
set -x PATH $PATH:/snap/bin

# exa pointer (to use in wrapper function)
function _exa
    /usr/local/bin/exa $argv
end

# ls pointer (to use in wrapper funciton)
function _ls
    /usr/bin/ls --color=auto $argv
end

# sudo or sudo equivalent pointer (for cygwin, android, etc.)
function sudo
    /usr/bin/sudo $argv
end

# xdg-open or equivalent pointer
function open
    xdg-open "$argv"
end

# Open a url link
function url
    google-chrome "$argv"
end

# Update local configs from github gists
function update-local
    wget -O $BIN/Config/system/local.fish https://gist.githubusercontent.com/TheAllSeeing/a37ad2da8d06dbd8aca5ad2d04232b53/raw/c95f2ea49e690fac31cf0f1c3a2bb902ad0787b8/local.fish
    wget -O $BIN/Config/system/local.py https://gist.github.com/TheAllSeeing/f1021dc01dc7636f00e456ae8b10e70e/raw/dccd67868482e924be62d0b6a8a5f7cd84890991/local.py
    wget -O $BIN/Config/system/local.sh https://gist.github.com/TheAllSeeing/f1021dc01dc7636f00e456ae8b10e70e/raw/dccd67868482e924be62d0b6a8a5f7cd84890991/local.sh
end