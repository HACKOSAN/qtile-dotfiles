from libqtile import bar, qtile, lazy

from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

from utils.settings import colors, workspace_names

import os

home = os.path.expanduser("~")

group_box_settings = {
    "active": colors[18],
    "block_highlight_text_color": colors[18],
    "this_current_screen_border": colors[18],
    "this_screen_border": colors[18],
    "urgent_border": colors[3],
    "background": colors[22],  # background is [10-12]
    "other_current_screen_border": colors[22],
    "other_screen_border": colors[22],
    "highlight_color": colors[13],
    "inactive": colors[14],
    "foreground": colors[21],
    "borderwidth": 2,
    "disable_drag": True,
    "fontsize": 14,
    "highlight_method": "line",
    "padding_x": 10,
    "padding_y": 16,
    "rounded": False,
}

# functions for callbacks
def open_launcher():
    qtile.cmd_spawn("rofi -show drun -theme ~/.config/rofi/launcher.rasi")


def open_powermenu():
    qtile.cmd_spawn("/home/lukka/.config/rofi/powermenu/type-2/powermenu.sh")

def toggle_maximize():
    lazy.window.toggle_maximize()


def parse_window_name(text):
    """Simplifies the names of a few windows, to be displayed in the bar"""
    target_names = [
        "Mozilla Firefox",
        "Visual Studio Code",
        "Discord",
    ]
    return next(filter(lambda name: name in text, target_names), text)


# separator
def separator():
    return widget.Sep(
        # foreground=colors[18],
        foreground=colors[22],
        padding=4,
        linewidth=3,
    )


def separator_sm():
    return widget.Sep(
        # foreground=colors[18],
        foreground=colors[22],
        padding=1,
        linewidth=1,
        size_percent=55,
    )

# widget decorations
base_decor = {
    "colour": colors[22],
    "filled": True,
    "padding_y": 4,
    "line_width": 0,
}

def _left_decor(color, padding_x=None, padding_y=4):
    return [
        RectDecoration(
            colour=color,
            radius=4,
            filled=True,
            padding_x=padding_x,
            padding_y=padding_y,
        )
    ]


def _right_decor(color):
    return [
        RectDecoration(
            colour=colors[22],
            radius=4,
            filled=True,
            padding_y=4,
            padding_x=0,
        )
    ]


# bar icon
bar_icon = widget.Image(
    background=colors[18],
    margin_x=14,
    margin_y=3,
    mouse_callbacks={"Button1": open_launcher},
    filename="~/.config/qtile/icons/arch.png",
)

# left icon
w_sys_icon = widget.TextBox(
    text="",
    font="Font Awesome 6 Free Solid",
    fontsize=22,
    foreground="#D9E0EE",
    background=colors[18],
    padding=16,
    mouse_callbacks={"Button1": open_launcher},
)

# workspace groups
w_groupbox_1 = widget.GroupBox(  # WEB
    font="Font Awesome 6 Brands",
    visible_groups=[workspace_names[0]],
    **group_box_settings,
)

w_groupbox_2 = widget.GroupBox(  # DEV, SYS
    font="Font Awesome 6 Free Solid",
    visible_groups=[workspace_names[1], workspace_names[2]],
    **group_box_settings,
)

w_groupbox_3 = widget.GroupBox(  # DISC, MUS
    font="Font Awesome 6 Brands",
    visible_groups=[workspace_names[3], workspace_names[4]],
    **group_box_settings,
)

w_groupbox_4 = widget.GroupBox(  # FILE, NOT
    font="Font Awesome 6 Free Solid",
    visible_groups=[workspace_names[5], workspace_names[6]],
    **group_box_settings,
)

w_groupbox_5 = widget.GroupBox(  # CHROME, NULL
    font="Font Awesome 6 Free Solid",
    visible_groups=[workspace_names[7], workspace_names[8]],
    **group_box_settings,
)



def gen_groupbox():
    return (
        widget.GroupBox(  # web
            font="Font Awesome 6 Brands",
            visible_groups=[workspace_names[0]],
            **group_box_settings,
        ),
        widget.GroupBox(  # dev, terminal
            font="Font Awesome 6 Free Solid",
            visible_groups=[workspace_names[1], workspace_names[2]],
            **group_box_settings,
        ),
        widget.GroupBox(  # dc, spotify
            font="Font Awesome 6 Brands",
            visible_groups=[workspace_names[3], workspace_names[4]],
            **group_box_settings,
        ),
        widget.GroupBox(  
            font="Font Awesome 6 Free Solid",
            visible_groups=[workspace_names[5], workspace_names[6]],
            **group_box_settings,
        ),
        widget.GroupBox(  # web2n, ferdium
            font="Font Awesome 6 Free Solid",
            visible_groups=[workspace_names[7], workspace_names[8]],
            **group_box_settings,
        ),
    )

# spacers
def gen_spacer():
    return widget.Spacer()

# window icon & name
w_window_name_icon = widget.TextBox(
    text=" ",
    foreground="#ffffff",
    font="Font Awesome 6 Free Solid",
)

w_window_name = widget.WindowName(
    foreground="#ffffff",
    width=bar.CALCULATED,
    empty_group_string="Desktop",
    max_chars=18,
    parse_text=parse_window_name,
    mouse_callbacks={"Button1": toggle_maximize},
)

# systray
w_systray = widget.Systray(
    padding=5,
)

# volume
w_volume_icon = widget.TextBox(
    text="墳",
    foreground=colors[10],
    font="JetBrainsMono Nerd Font",
    fontsize=20,
    padding=8,
    decorations=_left_decor(colors[18]),
)

w_volume = widget.PulseVolume(
    foreground=colors[18],
    limit_max_volume="True",
    # mouse_callbacks={"Button3": open_pavu},
    padding=8,
    decorations=_right_decor(colors[6]),
)

# time, calendar
def gen_clock():
    color = colors[18]

    return (
        widget.TextBox(
            text="",
            font="JetBrainsMono Nerd Font",
            fontsize=16,
            foreground=colors[22],  # blue
            padding=8,
            decorations=_left_decor(color),
        ),
        separator_sm(),
        widget.Clock(
            format="%b %d, %H:%M",
            foreground=color,
            padding=8,
            decorations=_right_decor(color),
        ),
        separator(),
    )


# power menu
w_power = widget.TextBox(
    text="⏻",
    background=colors[18],
    foreground="#000000",
    font="Font Awesome 6 Free Solid",
    fontsize=18,
    padding=16,
    mouse_callbacks={"Button1": open_powermenu},
)