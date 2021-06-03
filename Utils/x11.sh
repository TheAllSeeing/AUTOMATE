#!/bin/env bash

function get_win_by_class() {
    wins=$(wmctrl -lx)

    # Var decleration - to escape dots
    class_var="class"
    class_val="$1" # Input is

    awk_cond="\$3==class" # $3 - the third word, WM_CLASS for wmctrl -lx
    awk_comm='print $1' # $1 - the window id
    # echo echo \$\(wmctrl -lx\) \| awk $variable_options "\"{$awk_comm}\""
    echo "$(wmctrl -lx)" | awk -v "$class_var=$class_val" "$awk_cond{$awk_comm}"
    # echo $wins | awk -v class="$1" "\$3==class{print \$1}"
}

# function


function get_win_by_title() {

    wins=$(wmctrl -l)
    # $0 - the entire line (awk and wmctrl are space delimited,
    # but title may contain spaces)
    # $1 - the input title substring
    awk_cond="\$0 ~ $1"
    awk_comm='print $1' # $1 - the window id

    echo $wins | awk "$awk_cond{$awk_comm}"

}
