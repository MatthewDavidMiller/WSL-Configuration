#!/bin/bash
# Script to configure Windows Subsystem for Linux
# WSL disto used is Debian 10

# Get needed scripts
wget -O 'wsl_scripts.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts.sh'
wget -O 'distro_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/distro_options.sh'

# Source variables
source env.sh

# Source functions
source wsl_scripts.sh

# Source options
source distro_options.sh
