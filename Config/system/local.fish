#!/bin/fish


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
    xdg-open $argv
end
