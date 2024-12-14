add_to_path() {
    if [ $# -gt 2 ] || [ $# -lt 1 ] || [[ "$2"  && "$2" != "--before" ]]; then
        echo "Usage: add_to_path <dir> [--before]"
        return 1
    fi
    
    if [ -e "$1" ]; then
        if [ "$2" == "--before" ]; then
            export PATH="$1:$PATH"
        else
            export PATH="$PATH:$1"
        fi
        echo added $1 to PATH
    else
        echo $1 doesn\'t exist, not adding to PATH
    fi
    
}

run_once() {
    if [ $# -ne 1 ]; then
        echo "Usage: run_once <command>"
        return 1
    fi
    
    if ! pgrep -x "$1" >/dev/null; then
        echo starting $1
        $1 &
    fi
}

# ============================================================================================ #
# misc.
export EDITOR=nvim
export TERM=xterm-256color
export XMONAD_XMESSAGE=alacritty
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
alias code="code-insiders"
# --------------------------------------------------------------------------------------------


# ============================================================================================ #
# path
add_to_path "/usr/share/git-core/contrib"
add_to_path "$HOME/dev/alacritty/target/release/alacritty" --before
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.local/bin"
# exit

# add all non-hidden subdirectories of $HOME/bin:
if [ -d "$HOME/bin" ]; then
    for dir in $(find $HOME/bin/ -type d ! -path '*/.*' ! -path '*/node_modules/*'); do
        add_to_path "$dir"
    done
fi
# # --------------------------------------------------------------------------------------------


# # ============================================================================================ #
# # run apps
confwacom 2>/dev/null
run_once "dunst"
# run_once "xbanish"
run_once "volnoti"
/usr/libexec/polkit-gnome-authentication-agent-1 &
nitrogen --restore
xmodmap -e "keycode 66 = Escape"
xmodmap -e "clear Lock"
xautolock -time 30 -locker "systemctl suspend" -detectsleep &
picom &

# Start ActivityWatch only if not already started
if [ -z "$AW_STARTED" ]; then
    export AW_STARTED=true
    cd $HOME/dev/activitywatch
    source ./venv/bin/activate
    nohup aw-watcher-afk > /dev/null 2>&1 &
    nohup ./aw-server-rust/target/release/aw-server 2>&1 &
    nohup aw-watcher-window > /dev/null 2>&1 &
    disown
    deactivate
fi

#  clone-firefox-profile 3 --reset &

if [ -f "$HOME/.screenlayout/multihead.sh" ]; then
    source $HOME/.screenlayout/multihead.sh
else
    configure-multihead
fi
# # --------------------------------------------------------------------------------------------
