#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : MPD (music)

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

lastUrl=$(tail -n1 /home/lukka/scripts/get-track-image/history.txt)
trackUrl=$(playerctl --player=spotify metadata mpris:artUrl)

if [ "$trackUrl" == "$lastUrl" ]; then
    echo "As URLs são iguais. Abortando o script."
else
    echo "As URLs são diferentes. Continuando com o script."
    rm -rf /home/lukka/scripts/get-track-image/current.jpg
    getPic=$(wget -q -T 3 -t 1 $trackUrl -O /home/lukka/scripts/get-track-image/current.jpg)
    sendHist=$(echo $trackUrl >> /home/lukka/scripts/get-track-image/history.txt)
fi

# Theme Elements
status="`playerctl -l | grep spotify`"
if [[ -z "$status" ]]; then
	prompt='Offline'
	mesg="PlayerCTL is Offline"
else
	prompt="`playerctl --player=spotify metadata xesam:artist`"
	mesg="`playerctl --player=spotify metadata xesam:title`"
fi

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='4'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='4'
	list_row='1'
fi

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	if [[ ${status} == *"[playing]"* ]]; then
		option_1=" Pause"
	else
		option_1=" Play"
	fi
	option_2=" Stop"
	option_3=" Previous"
	option_4=" Next"
else
	if [[ ${status} == *"[playing]"* ]]; then
		option_1=""
	else
		option_1=""
	fi
	option_2=""
	option_3=""
	option_4=""
	option_5=""
	option_6=""
fi

# Toggle Actions
active=''
urgent=''

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		playerctl --player=spotify play-pause
	elif [[ "$1" == '--opt2' ]]; then
		playerctl --player=spotify pause
	elif [[ "$1" == '--opt3' ]]; then
		playerctl --player=spotify previous
	elif [[ "$1" == '--opt4' ]]; then
		playerctl --player=spotify next
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
esac
