 if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Set up the prompt
eval "$(starship init zsh)"

# Note for changing sound card:
# pacmd set-card-profile 7 input:analog-stereo
# pavucontrol

source ~/.nix-profile/share/zsh-nix-shell/nix-shell.plugin.zsh # still necessary?
source ~/.local-keys

setopt histignorealldups sharehistory

# Use vi keybindings even if our EDITOR is set to vi
bindkey -v
bindkey 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export PATH=$HOME/bin:$PATH

# For Rust
export PATH=$HOME/.cargo/bin:$PATH

# For doom emacs
export PATH=$HOME/.config/emacs/bin:$PATH
alias emacs='emacs -nw'

# for laptop brightness
function brightness () {
    echo $1 | sudo tee /sys/class/backlight/intel_backlight/brightness
}

#Aliases
alias cat='bat -pp'
alias blog='fd ~/projects/golang/src/github.com/hwchen/hwc'
alias web='fd ~/projects/golang/src/github.com/hwchen/hwchen.github.io'
alias ag='rg'
alias rr="reddit-focus"
alias find='~/.cargo/bin/fd'
#alias tygem="wine .wine/drive_c/Program\ Files\ \(x86\)/TygemGlobal/TygemGlobal.exe &"
alias liz="fd ~/src/lizzie && java -jar 'target/lizzie-0.6-shaded.jar'"
alias hm="home-manager"
alias hms="home-manager switch"

#Volume

alias vmute='amixer -D pulse sset Master 0%'
alias vu='amixer -D pulse sset Master 5%+'
alias vd='amixer -D pulse sset Master 5%-'
alias vh='amixer -D pulse sset Master 25%'
alias vmax='amixer -D pulse sset Master 100%'

#display
alias display='feh'

#Remove flow control
stty -ixon

#fn for cd ls
function fd () {
    cd $1 && ls --color --group-directories-first
}
alias ls='ls --color --group-directories-first'

# Time
disable -r time
alias time='time -p'

# multimonitor setup

alias horizontal='xrandr --output HDMI-A-0 --rotate normal --auto --left-of DisplayPort-0 --output DisplayPort-0 --rotate normal'
alias vertical='xrandr --output HDMI-A-0 --rotate left --auto --left-of DisplayPort-0 --output DisplayPort-0 --rotate right'

# video sharing for constrained window
# https://unix.stackexchange.com/questions/152435/sharing-your-desktop-with-google-hangouts-dual-monitor-and-gnome-shell
# vlc \
#    --no-video-deco \
#    --no-embedded-video \
#    --screen-fps=20 \
#    --screen-top=32 \
#    --screen-left=0 \
#    --screen-width=4320 \
#    --screen-height=2160 \
#    screen://

# entrez direct
export PATH="$HOME/bin/edirect:$PATH"

# kitty ssh
# might be a bit dangerous, it's not a drop in for ssh
alias ssh='kitty +kitten ssh'

# use nvim
alias vim=nvim
# this also uses a .fdignore
export FZF_DEFAULT_COMMAND='~/.cargo/bin/fd --type f --hidden --follow --no-ignore-vcs --exclude zig-cache'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"

# git recent branches
# TODO make a real history of branch checkouts w/ fuzzy search
alias bstack='f() { git reflog | grep checkout | grep -v rebase | cut -d " " -f 8 | ouniq | head -${1} | cat -n };f'
alias bjmp='fn() { bstack ${1} | tail -1 | cut -f 2 | xargs git checkout  }; fn'
alias bb="bjmp 2"

# ripgrep w/ pigz
rgz() { rg --pre rg-pigz --pre-glob '*.gz' "$@"; }


if [ -e /home/hwchen/.nix-profile/etc/profile.d/nix.sh ]; then . /home/hwchen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# redshift
alias redshift-loc='redshift -l 42:-71'

# keychain
keychain id_rsa
. ~/.keychain/`uname -n`-sh

# todoist
todoist-project-id-by-name() { curl -s -X GET https://api.todoist.com/rest/v2/projects -H "Authorization: Bearer $TODOIST_API_TOKEN" | jq -r --arg PNAME "$1" '.[] | select(.name == $PNAME) | .id' }
todoist-project-tasks-by-pid() { curl -s -X GET "https://api.todoist.com/rest/v2/tasks?project_id=$1" -H "Authorization: Bearer $TODOIST_API_TOKEN" | jq -r '.[].content'}
todoist-task-list() { todoist-project-tasks-by-pid $(todoist-project-id-by-name "$1") }

# If there's issues w/ lxd/incus connectivity (because of docker) run:
# https://documentation.ubuntu.com/lxd/en/latest/howto/network_bridge_firewalld/#prevent-connectivity-issues-with-lxd-and-docker
# In future, try to make this persistent across boots
# sudo iptables -I DOCKER-USER -i incusbr0 -j ACCEPT
# sudo iptables -I DOCKER-USER -o incusbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Get addresses of containers using the lxc bridge network
alias incus-ls="incus list"

# nixos containers need to launch with security nesting = true for now
# https://discuss.linuxcontainers.org/t/nixos-images-broken-on-incus-running-on-ubuntu-with-kernel-6-5/18856/12
# incus launch images:nixos/23.11 -c security.nesting=true

# for when not using kb
alias kbcaps='setxkbmap -option "caps:swapescape"'
alias ungron='gron -u'
