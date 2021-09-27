# AUTOMATE
A project to automate frequent actions I employ in my system, 
such that they can be ran by typing a command or pressing a hotkey, 
or alternatively run as daemons and preform the action completely automatically.

## Structure
The project divides its script into four exclusive directories which categorize 
the way a script runs and its intractability.

- **Launch** Scripts can be ran non-interactively and for a bound period of time, 
to preform a specific action. 

- **Shell** scripts should be ran interactively, either requiring user 
  input or only writing to stdout without any external actions.
- **Daemon** scripts should ran non-interactively in the background.
- **Utils** scripts should not be ran directly but instead sourced by 
other scripts to provide constants or some functionality.

## List of Scripts

1. **Launch**
   - `add-script` adds creates a script file in this project, grants it 
   execution permission and opens it in default editor.
   - `edit-script` finds the location of a script by name and opens it 
   in default editor
   - `focus` activates a window by title or WM class if it exists in the current (or first) workspace
   - `launch`  contains various small functions to launch apps with specific configuration or open a list of files for some task.
   - `logout` logs out of the current gnome-session
   - `media` control media and playlists on my Android via Termux AM and MacroDroid macro
   - `mode` switches between dark and light theme for a variety of applications (including gnome desktop)
   - `search` searches for a query in a given search engine using the engines defined in [search-engines.sh](https://github.com/TheAllSeeing/CONFIG/blob/allseer/Configs/sh/sh/search-engines.sh#L35)
   - `suspend` suspends the os on a systemd distro
   - `timer` clears the screen and displays a countdown given in hours, minutes (default) or seconds, and upon its end 
      plays tries the file ~/.local/share/timer/end (given it exists and is an audio file).
   - `tooth` manages bluetooth connections to my personal devices, including pair, unpair, connect, disconnect, re-pair 
      and turning bluetooth on and off.
   - `volume` allows simple and easy command-line adjustment of system volume as well as volume of indivdual apps (specified with pactl media.name)
   - `wifi` keeps a list of my common network and allows connecting them easily, allows switching to best available connection and restarting wifi.

1. Shell
   - `ls-color` lists color codes with apropriate foreground for 16-255
   - `recent` echoes the file most recently modified in a given directory
   - `show_color` lists colors by name assigned in colors.sh (see utils), with apropriate foreground
   - `ttest` creates a new file test.txt with contents "Hello\nWorld"
   
1. Daemon
   - `update-lyx.sh` sets up `inotifywait` watches on any lyx file in my home directory that is not in a dotfile directory, and compiles them automatically when they are saved.
   
1. Utils
   - `colors.sh` gives names to each color code based on the HTML color they are closest to, and assigns them to lowercase variables. It then assignes enviornment variables to each terminal text color string based on their code names.
   - `x11.sh` provides utilities to get window id by title name or class 
