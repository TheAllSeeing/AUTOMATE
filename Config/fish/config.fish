#!/bin/fish

[ -f ~/.config/fish/local.fish ] && source ~/.config/fish/local.fish

# CONFIGURATIONS

function git --wraps hub --description 'Alias for hub, which wraps git to provide extra functionality with GitHub.' # use hub commands with git
    hub $argv
end

function fish_title # Set terminal window title
    echo "Fish ($FISH_WINDOW_ID)"
end




# Directory Variables sourced from ~/.profile
# PATH sourced from ~/.profile




# FILE VARIABLES
set -x FISHRC ~/.config/fish/config.fish
set -x BASHRC ~/.bashrc
set -x EMACSRC ~/.emacs.d/init.el
set -x DOOMRC ~/.doom.d/init.el

# ALIASES
# Utilities
alias ll="exa -alF"
alias xcopy="xclip -sel clip"
alias xpaste="xclip -sel clip -o"

# Shorten Names
alias open="xdg-open"
alias del="rmtrash"
alias tsm=transmission-remote

# Purpose Aliases
alias edit="emacs"

# Command options
alias mv='mv -i'
alias cp='cp -i'
alias emacs='emacsclient -a emacs -nc'



# PERSONAL FUNCTIONS
function rmd # Read Markdown
	pandoc -s "$argv" | lynx -stdin
end

# FUNCTIONS MODIFICATIONS

function exa

    set home_hidden "wpilib|snap|Shuffleboard"
    set calibre_hidden "metadata*"
    set type_hidden "*.lyx~|*.lyx#"

    # If -a option given, just show all.
    if [ -n "$argv" ] && string match -- "*-*a*" "$argv"
            _exa $argv; return $status
    end

    # Hide files as coded based on directory
    switch $PWD
    case $HOME
        _exa -I "$home_hidden|$type_hidden" $argv
    case "$MEDIA/Prose/Books"
        _exa -I "$calibre_hidden|$type_hidden" $argv
    case '*'
        _exa -I "$type_hidden" $argv
    end

# COMPILES: Yes
# RUNS: Yes
# WORKS: Yes
# BUGS (FIXME):
# - If a specific directory is given, filters for the working directory are applied (as just $PWD is tested againt).
#   Need to find the directory arguments, and handle different filters for multiple directories.
# - Testing for -a option accepts all options that include the letter a somewhere (e.g --accessed, --created).
#   Neeed to replace with more proper RegEx (something like -[^-::space::]*a[^-::space::]*)

end



function ls

    # To avoid repetition, keep filter options as strings and evaluate them dynamically based on working directory.
    set home_options "-I wpilib -I snap -I Shuffleboard"
    set calibre_options "-I metadata*"
    set type_options "-I \"*.lyx~\" -I \"*.lyx#\""

    # If -a option given, just show all.
    if [ -n "$argv" ] && string match -- "*-*a*" "$argv"
            _ls $argv; return $status
    end

    # Hide files as coded based on directory
    switch $PWD
    case $HOME
        eval "_ls $home_options $type_options $argv"
    case "$MEDIA/Prose/Books"
        eval "_ls $calibre_options $type_options $argv"
    case '*'
        eval "_ls $type_options $argv"
    end

# COMPILES: Yes
# RUNS: Yes
# WORKS: Yes
# BUGS (FIXME):
# - If a specific directory is given, filters for the working directory are applied (as just $PWD is tested againt).
#   Need to find the directory arguments, and handle different filters for multiple directories.
# - Testing for -a option accepts all options that include the letter a somewhere (e.g --accessed, --created).
#   Neeed to replace with more proper RegEx (something like -[^-::space::]*a[^-::space::]*)

end
