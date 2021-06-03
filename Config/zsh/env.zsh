#!/usr/bin/env zsh

#
[ -f ~/.bash_local ] && source ~/.bash_local

# ===Search Engine Configurations===
_def_search_engine() {
    engine_name="$1"
    addr="$2"
    search_addr="$2/$3"

    source <(cat<<EOF
        function $engine_name() {
            if [[ -z "\$@" ]]; then
                echo opening $addr
                url $addr
            else
                sed_str="s/%s/\$@/"
                url "\$(echo '$search_addr' | sed "\$sed_str")"
            fi
        }
EOF
    )
}

[ -f ~/.search_engines ] && source ~/.search_engines
# ======
