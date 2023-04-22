#!/bin/fish
#  _   _    _    ____ _  _____  ____    _    _   _
# | | | |  / \  / ___| |/ / _ \/ ___|  / \  | \ | |
# | |_| | / _ \| |   | ' / | | \___ \ / _ \ |  \| |
# |  _  |/ ___ \ |___| . \ |_| |___) / ___ \| |\  |
# |_| |_/_/   \_\____|_|\_\___/|____/_/   \_\_| \_|

# lukka@devilgothies
# Check out devilgothies home repo -> https://github.com/devilgothies
# my fork -> https://github.com/HACKOSAN/qtile-dotfiles
# This is just my fish config, enjoy!

# Sourcing my infosec stuff configs
source /home/hacko/.config/fish/cyber.fish

# Environment
set fish_greeting
set -x PATH /home/hacko/.local/bin/ /home/lukka/go/bin $PATH

# ──────── 《 Abbreviations 》 ────────
abbr ifc ifconfig
abbr cl clear
abbr nv nvim

# ─────────── 《 Aliases 》 ───────────
# General
alias rl='readlink -f'
alias cls='clear ; cd'
alias logoff='sh /usr/bin/logoff.sh'
alias dog='/usr/bin/cat'
alias rf='rm -rf'
alias surfd='/usr/bin/surf duckduckgo.com'
alias surfg='/usr/bin/surf google.com'
alias hist='history'
alias xcc='xclip -selection clipboard -o'
alias clip='xsel -i -b'
alias b64='base64'
alias bd='base64 -d'
alias fuck='sudo'
alias pping='/usr/bin/ping'
alias note='dnote'
alias md='mkdir'
alias chx='chmod +x'
alias hosts='sudo $EDITOR /etc/hosts'

# Git
alias gist='gh gist create'
alias gistp='gh gist create --public'

# Prettier output
alias ip='ip -color=auto'
alias dmesg='dmesg --color=always'
alias ping='prettyping'
alias cat='bat'
alias catp='bat --paging=never'

# Shells
alias b='bash'
alias z='zsh'
alias f='fish'

# Changing keyboard layout
alias setar='setxkbmap -layout ar'
alias setus='setxkbmap -layout us'

# Human readability
alias df='df -h'
alias free='free -h'

# Fast edit/read configs
alias qtileconf='nvim /home/lukka/.config/qtile/config.py'

# Visual configs
alias panes='/opt/shell-color-scripts/colorscripts/panes'
alias fehbgr='feh --bg-fill $(shuf -n 1 -e /home/lukka/Imagens/wallpapers/*)'
alias clock='tty-clock -c -C4'

# "ls" to "exa"
alias ls='exa --color=always --group-directories-first' 
alias l='exa --color=always --group-directories-first' 
alias la='exa -la --color=always --group-directories-first'
alias ll='exa -lah --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'

# Package managers
alias pacs='sudo pacman -S'
alias pacsyu='sudo pacman -Syu'
alias pacsyyu='sudo pacman -Syyu'
alias ys='yay -S'
alias yaysua='yay -Sua --noconfirm'
alias yaysyu='yay -Syu --noconfirm'

alias psa='ps auxf'
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Player control
alias next='playerctl next'
alias prev='playerctl previous'
alias pp='playerctl play-pause'


# ────────── 《 Functions 》 ──────────
function extract
	if test -f "$1"
		set filename (basename "$1")
		set foldername (echo "$filename" | sed 's/\.[^.]*$//')
		set fullpath (perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$1")
		set didfolderexist false
		if test -d "$foldername"
			set didfolderexist true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if test "$REPLY" = "n" or "$REPLY" = "N"
				return
			end
		end
		mkdir -p "$foldername" && cd "$foldername"
		switch "$1"
			case '*.tar.bz2'
				tar xjf "$fullpath"
				;;
			case '*.tar.gz'
				tar xzf "$fullpath"
				;;
			case '*.tar.xz'
				tar Jxvf "$fullpath"
				;;
			case '*.tar.Z'
				tar xzf "$fullpath"
				;;
			case '*.tar'
				tar xf "$fullpath"
				;;
			case '*.taz'
				tar xzf "$fullpath"
				;;
			case '*.tb2'
				tar xjf "$fullpath"
				;;
			case '*.tbz'
				tar xjf "$fullpath"
				;;
			case '*.tbz2'
				tar xjf "$fullpath"
				;;
			case '*.tgz'
				tar xzf "$fullpath"
				;;
			case '*.txz'
				tar Jxvf "$fullpath"
				 ;;
			case '*.zip'
				unzip "$fullpath"
				;;
			# Default case.
			case '*'
				echo "'$1' cannot be extracted via extract()"
				cd ..
				if not $didfolderexist
					rm -r "$foldername"
				end
				;;
		end
	else
		echo "'$1' is not a valid file"
	end
end

function jctl # Application logs
    journalctl -qb /usr/bin/$1
end

function cpr # Copy with progress
  rsync -WavP --human-readable --progress $1 $2
end

function mdc # Create and enter into directory
    mkdir $argv[1]
    cd $argv[1]
end

function geo # Geolocation of an IP address
    curl https://ipinfo.io/$argv[1] -s | jq
end

function mygeo # My geolocation
    geo $(curl ifconfig.me -s)
end

function gitsize # Calculate size of a Github repository
  echo $argv[1]  | perl -ne 'print $1 if m!([^/]+/[^/]+?)(?:\.git)?$!' | xargs -I{} curl -s -k https://api.github.com/repos/'{}' | jq '.size' | numfmt --to=iec --from-unit=1024
end