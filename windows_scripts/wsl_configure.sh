#!/bin/bash
# Script to configure Windows Subsystem for Linux
# WSL disto used is Debian 10

# Get needed scripts
mkdir -p 'wsl_scripts'
wget -O 'wsl_scripts/wsl_scripts.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts/wsl_scripts.sh'
wget -O 'wsl_scripts/distro_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts/distro_options.sh'
wget -O 'wsl_scripts/functions.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/Bash-Common-Functions/main/functions/functions.sh'

# Source variables
source 'wsl_scripts/env.sh'

# Source functions
source 'wsl_scripts/wsl_scripts.sh'
source 'wsl_scripts/functions.sh'

# Source options
source 'wsl_scripts/distro_options.sh'
