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
    xdg-open $@
}

# System-Specific App Configurations
source /usr/share/undistract-me/long-running.bash
notify_when_long_running_commands_finish_install
