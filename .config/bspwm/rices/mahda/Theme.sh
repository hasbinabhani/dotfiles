#!/usr/bin/env bash
#  ██╗   ██╗ █████╗ ███████╗██╗
#  ╚██╗ ██╔╝██╔══██╗██╔════╝██║
#   ╚████╔╝ ███████║█████╗  ██║
#    ╚██╔╝  ██╔══██║██╔══╝  ██║
#     ██║   ██║  ██║███████╗███████╗
#     ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Terminate existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash
. "${HOME}"/.cache/wal/colors.sh
# Current Rice
read -r RICE <"$HOME"/.config/bspwm/.rice

# Vars config for Yael Rice
# Bspwm border		# Fade windows true|false	# Shadows true|false	# Corner radius
BORDER_WIDTH="1" P_FADE="true" P_SHADOWS="true" P_CORNER_R="10"

# (OxoCarbon) colorscheme
#bg="#161616" fg="#ffffff"

#black="#262626" red="#ee5396" green="#42be65" yellow="#ffe97b"
#blackb="#393939" redb="#ee5396" greenb="#42be65" yellowb="#ffe97b"

#blue="#33b1ff" magenta="#ff7eb6" cyan="#3ddbd9" white="#dde1e6"
#blueb="#33b1ff" magentab="#ff7eb6" cyanb="#3ddbd9" whiteb="#ffffff"
bg="$background" fg="$foreground"

black="$color0" red="$color1" green="$color2" yellow="$color3"
blackb="$color8" redb="$color9" greenb="$color10" yellowb="$color11"

blue="$color4" magenta="$color5" cyan="$color6" white="$color7"
blueb="$color12" magentab="$color13" cyanb="$color14" whiteb="$color15"
# Set bspwm configuration
set_bspwm_config() {
  bspc config border_width ${BORDER_WIDTH}
  bspc config top_padding 2
  bspc config bottom_padding 4
  bspc config left_padding 2
  bspc config right_padding 2
  bspc config normal_border_color "${red}"
  bspc config active_border_color "${green}"
  bspc config focused_border_color "${blue}"
  bspc config presel_feedback_color "${black}"
}

# Terminal colors
set_term_config() {
  cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# Default colors
[colors.primary]
background = "${bg}"
foreground = "${fg}"

# Cursor colors
[colors.cursor]
cursor = "${blue}"
text = "${bg}"

# Normal colors
[colors.normal]
black = "${black}"
red = "${red}"
green = "${green}"
yellow = "${yellow}"
blue =  "${blue}"
magenta = "${magenta}"
cyan = "${cyan}"
white = "${white}"

# Bright colors
[colors.bright]
black = "${blackb}"
red = "${redb}"
green = "${greenb}"
yellow = "${yellowb}"
blue =  "${blueb}"
magenta = "${magentab}"
cyan = "${cyanb}"
white = "${whiteb}"
EOF

  # Set kitty colorscheme
  cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
# The basic colors
foreground              ${fg}
background              ${bg}
selection_foreground    ${bg}
selection_background    ${whiteb}

# Cursor colors
cursor                  ${blue}
cursor_text_color       ${bg}

# URL underline color when hovering with mouse
url_color               ${green}

# Kitty window border colors
active_border_color     ${blue}
inactive_border_color   ${black}
bell_border_color       ${yellow}

# Tab bar colors
active_tab_foreground   ${bg}
active_tab_background   ${blue}
inactive_tab_foreground ${bg}
inactive_tab_background ${cyan}
tab_bar_background      ${bg}

# The 16 terminal colors

# black
color0 ${black}
color8 ${blackb}

# red
color1 ${red}
color9 ${redb}

# green
color2  ${green}
color10 ${greenb}

# yellow
color3  ${yellow}
color11 ${yellowb}

# blue
color4  ${blue}
color12 ${blueb}

# magenta
color5  ${magenta}
color13 ${magentab}

# cyan
color6  ${cyan}
color14 ${cyanb}

# white
color7  ${white}
color15 ${whiteb}
EOF

  pidof -x kitty && killall -USR1 kitty
}
#
# Set compositor configuration
set_picom_config() {
  sed -i "$HOME"/.config/bspwm/picom.conf \
    -e "s/normal = .*/normal =  { fade = ${P_FADE}; shadow = ${P_SHADOWS}; }/g" \
    -e "s/shadow-color = .*/shadow-color = \"${bg}\"/g" \
    -e "s/corner-radius = .*/corner-radius = ${P_CORNER_R}/g" \
    -e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
    -e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
    -e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst config
set_dunst_config() {
  sed -i "$HOME"/.config/bspwm/dunstrc \
    -e "s/transparency = .*/transparency = 0/g" \
    -e "s/frame_color = .*/frame_color = \"${bg}\"/g" \
    -e "s/separator_color = .*/separator_color = \"${cyan}\"/g" \
    -e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
    -e "s/foreground='.*'/foreground='${blue}'/g"

  sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
  cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "${bg}"
		foreground = "${green}"

		[urgency_normal]
		timeout = 5
		background = "${bg}"
		foreground = "${fg}"

		[urgency_critical]
		timeout = 0
		background = "${bg}"
		foreground = "${red}"
	_EOF_
}

# Set eww colors
set_eww_colors() {
  cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
\$bg: ${bg};
\$bg-alt: #212121;
\$fg: ${fg};
\$black: ${black};
\$red: ${red};
\$green: ${green};
\$yellow: ${yellow};
\$blue: ${blue};
\$magenta: ${magenta};
\$cyan: ${cyan};
\$archicon: #0f94d2;
EOF
}
##
set_warna_polybar() {
  cat >"$HOME"/.config/bspwm/src/warnarice.ini <<EOF
[color]
bg = "${bg}"
fg = "${fg}"
red = "${red}"
pink = ${redb}
purple = #ff7eb6
blue = $blue
blue-arch = #0A9CF5
cyan = $cyan
teal = #00B19F
green = $green
lime = #B9C244
yellow = $yellow
amber = #FBC02D
orange = #E57C46
brown = #AC8476
grey = $whiteb
indigo = #82CFFF
blue-gray = #43789C
coklat = #B6630C  
EOF
}
set_launchers() {
  # Jgmenu
  sed -i "$HOME"/.config/bspwm/jgmenurc \
    -e "s/color_menu_bg = .*/color_menu_bg = ${bg}/" \
    -e "s/color_norm_fg = .*/color_norm_fg = ${fg}/" \
    -e "s/color_sel_bg = .*/color_sel_bg = ${blue}/" \
    -e "s/color_sel_fg = .*/color_sel_fg = ${bg}/" \
    -e "s/color_sep_fg = .*/color_sep_fg = ${red}/"

  # Rofi launchers
  cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Yael

* {
    font: "JetBrainsMono NF Bold 9";
    background: ${bg};
    background-alt: ${bg}E0;
    foreground: ${fg};
    selected: ${blue};
    active: ${green};
    urgent: ${red};

    img-background: url("~/.config/bspwm/rices/${RICE}/rofi.webp", width);
}
EOF
}

# Launch theme
launch_theme() {

  # Launch polybar
  for mon in $(polybar --list-monitors | cut -d":" -f1); do
    MONITOR=$mon polybar -q mahda -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
  done

  # Set random wallpaper for actual rice
  # feh -z --no-fehbg --bg-fill "${HOME}"/.config/bspwm/rices/"${RICE}"/walls
  wal -i "${HOME}"/.config/bspwm/rices/"${RICE}"/walls
  # Launch dunst notification daemon
  dunst -config "${HOME}"/.config/bspwm/dunstrc &
}

### Apply Configurations

set_bspwm_config
set_term_config
set_warna_polybar
set_picom_config
set_dunst_config
launch_theme
set_eww_colors
set_launchers
