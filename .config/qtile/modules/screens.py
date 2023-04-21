from libqtile import bar
from libqtile.config import Screen
from qtile_extras import widget
from modules.widgets import *
from utils.settings import colors, two_monitors, wallpaper_main, wallpaper_sec

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=15,
    padding=2,
    background=colors[22],
)
extension_defaults = widget_defaults.copy()

def create_bar(extra_bar = False):
    """Create top bar, defined as function to allow duplication in other monitors"""
    return bar.Bar(
        [
            # w_sys_icon,
            bar_icon,

            # workspaces
            *gen_groupbox(),

            # left spacer
            gen_spacer(),

            # window icon & name
            w_window_name_icon,
            w_window_name,
            
            # Right spacer
            gen_spacer(),

            # hidden systray
            *((w_systray,) if not extra_bar else ()),
            separator(),

            # sound
            w_volume_icon,
            separator_sm(),
            w_volume,
            separator(),

            # clock
            *gen_clock(),

            # power button
            w_power,
        ],
        30,
        margin=[4, 6, 2, 6],
    )


main_screen_bar = create_bar()
if two_monitors:
    secondary_screen_bar = create_bar(True)

screens = [
    Screen(
        wallpaper=wallpaper_main,
        wallpaper_mode="fill",
        top=main_screen_bar,
        bottom=bar.Gap(2),
        left=bar.Gap(2),
        right=bar.Gap(2),
    ),
]

if two_monitors:
    screens.append(
        Screen(
            wallpaper=wallpaper_sec,
            wallpaper_mode="fill",
            top=secondary_screen_bar,
            bottom=bar.Gap(2),
            left=bar.Gap(2),
            right=bar.Gap(2),
        ),
    )
