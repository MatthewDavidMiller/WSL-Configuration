#!/bin/bash
# Script to configure Windows Subsystem for Linux
# WSL disto used is Debian 10

# Get needed scripts
apt-get update
apt-get install -y wget
wget -O 'wsl_scripts.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts.sh'

# Source functions
source wsl_scripts.sh

# Variables
dns_server_1='8.8.8.8'
dns_server_2='1.1.1.1'
user_name='matthew'

# Call functions
wsl_install_packages
wsl_setup_gui "${user_name}"
wsl_configure_bashrc "${user_name}"
wsl_mount_network_drives
wsl_copy_ssh_keys "${user_name}"
configure_dns "${dns_server_1}" "${dns_server_2}"
configure_git "${user_name}"
install_powershell
