#!/bin/fish
#     _         _ _          _   _    _        
#  __| |_____ _(_) |__ _ ___| |_| |_ (_)___ ___
# / _` / -_) V / | / _` / _ \  _| ' \| / -_|_-<
# \__,_\___|\_/|_|_\__, \___/\__|_||_|_\___/__/
#                  |___/                       
# lukka@devilgothies
# Check my Github -> https://github.com/devilgothies
# This is just my fish config, enjoy!

# Sourcing my infosec stuff configs
source /home/lukka/.config/fish/cyber.fish

# Environment
set fish_greeting
set -x PATH /home/lukka/.local/bin/ /home/lukka/go/bin $PATH

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

# Virtual box 
alias vm='VBoxManage'
alias vmlv='VBoxManage list vms'
alias vmlrv='VBoxManage list runningvms'

# Changing keyboard layout
alias setbr='setxkbmap -layout br'
alias setus='setxkbmap -layout us'

# Human readability
alias df='df -h'
alias free='free -h'

# Fast edit/read configs
alias pfg='cd /home/lukka/.config/'
alias i3conf='nvim /home/lukka/.config/i3/config'
alias qtileconf='nvim /home/lukka/.config/qtile/config.py'
alias awconf='nvim /home/lukka/.config/awesome/rc.lua'
alias config='cat /home/lukka/.config/fish/config.fish /home/lukka/.config/fish/cyber.fish'

# Grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gp='grep'
alias hg='history | grep $1'

# Networking tools
alias ifme='curl ifconfig.me'
alias ssp='ss -tupan | grep $1'
alias nethogs='sudo nethogs'
alias iftop='sudo iftop'
alias mm='mitmproxy'

# Visual configs
alias panes='/opt/shell-color-scripts/colorscripts/panes'
alias fehbgr='feh --bg-fill $(shuf -n 1 -e /home/lukka/Imagens/wallpapers/*)'
alias frenzch='/home/lukka/frenzch.sh/frenzch.sh'
alias clock='tty-clock -c -C4'

# "ls" to "exa"
alias ls='exa --color=always --group-directories-first' 
alias l='exa --color=always --group-directories-first' 
alias la='exa -la --color=always --group-directories-first'
alias ll='exa -lah --color=always --group-directories-first'
alias lt='exa -aT --color=always --group-directories-first'
alias l.='exa -a | grep -E "^\."'
alias lah='exa -lah --color=always --group-directories-first'
alias lsiso='ls -lh *.iso'
alias lsize='du -hs * | sort -hr | less'

# Package managers
alias pacs='sudo pacman -S'
alias pacsyu='sudo pacman -Syu'
alias pacsyyu='sudo pacman -Syyu'
alias ys='yay -S'
alias yaysua='yay -Sua --noconfirm'
alias yaysyu='yay -Syu --noconfirm'
alias parsua='paru -Sua --noconfirm'
alias parsyu='paru -Syu --noconfirm'
alias pt='pactree'
alias ptc='pactree -c'
alias ptr='pactree -rc'
alias ptu='pactree -u'

# Processes
alias psa='ps auxf'
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# Player control
alias next='playerctl next'
alias prev='playerctl previous'
alias pp='playerctl play-pause'

# Systemd
alias std='sudo systemctl start'
alias rrd='sudo systemctl restart'
alias stopd='sudo systemctl stop'
alias stts='systemctl status'
alias isfd='systemctl is-failed'

# Virtual Box
alias vmoff='VBoxManage controlvm $1 acpipowerbutton'
alias vmforceoff='VBoxManage controlvm $1 poweroff'
alias vmstart='VBoxManage startvm $1 --type separate'
alias vmstarth='VBoxManage startvm $1 --type headless'

# Logging
alias lastjctl='journalctl -p 3 -xb'

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