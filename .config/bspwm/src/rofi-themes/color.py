import json
import configparser
import os

# Path ke file colors.json dan config.ini
colors_json_path = os.path.expanduser('~/.cache/wal/colors.json')
config_ini_path = '~/.config/bspwm/src/rofi-themes/colorskema.ini'

# Baca file colors.json
with open(colors_json_path, 'r') as f:
    colors = json.load(f)

# Buat instance ConfigParser
config = configparser.ConfigParser()

# Hapus isi file config.ini
#open(config_ini_path, 'w').close()

# Tambahkan atau perbarui warna-warna ke dalam config.ini
config['Colors'] = {}
config['Colors']['bg'] = colors['special']['background']
config['Colors']['fg'] = colors['special']['foreground']
config['Colors']['cursor'] = colors['special']['cursor']
config['Colors']['black'] = colors['colors']['color0']
config['Colors']['red'] = colors['colors']['color1']
config['Colors']['green'] = colors['colors']['color2']
config['Colors']['yellow'] = colors['colors']['color3']
config['Colors']['blue'] = colors['colors']['color4']
config['Colors']['magenta'] = colors['colors']['color5']
config['Colors']['cyan'] = colors['colors']['color6']
config['Colors']['white'] = colors['colors']['color7']
config['Colors']['blackb'] = colors['colors']['color8']
config['Colors']['redb'] = colors['colors']['color9']
config['Colors']['greenb'] = colors['colors']['color10']
config['Colors']['yellowb'] = colors['colors']['color11']
config['Colors']['blueb'] = colors['colors']['color12']
config['Colors']['magentab'] = colors['colors']['color13']
config['Colors']['cyanb'] = colors['colors']['color14']
config['Colors']['whiteb'] = colors['colors']['color15']

# Tulis ulang file config.ini
#with open(config_ini_path, 'w') as configfile:
#    config.write(configfile)

