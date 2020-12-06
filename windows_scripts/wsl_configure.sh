#!/bin/bash
# Script to configure Windows Subsystem for Linux
# WSL disto used is Debian 10

# Get needed scripts
apt-get update
apt-get install -y wget
wget -O 'wsl_scripts.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts.sh'

# Source variables
source env.sh

# Source functions
source wsl_scripts.sh

# Call functions
wsl_install_packages
wsl_setup_gui "${user_name}"
wsl_configure_bashrc "${user_name}"
wsl_mount_network_drives
wsl_copy_ssh_keys "${user_name}"
configure_dns "${dns_server_1}" "${dns_server_2}"
configure_git "${user_name}"
install_powershell

PS3='Select Configuration Option: '
options=("Install Packages Debian" "Install Packages Kali Linux" "WSL Version 1 Setup GUI" "Configure Bashrc" "Mount Network Drives" "Copy SSH Keys" "WSL2 Configure DNS" "Configure Git" "Install PowerShell Core" "Configure Kali Linux GUI" "Quit")

select options_select in "${options[@]}"; do
    case $options_select in

    "Install Packages Debian")
        wsl_install_packages_debian
        ;;

    "Install Packages Kali Linux")
        wsl_install_packages_kali
        ;;

    "WSL Version 1 Setup GUI")
        wsl_setup_gui "${user_name}"
        ;;

    "Configure Bashrc")
        wsl_configure_bashrc "${user_name}"
        ;;

    "Mount Network Drives")
        wsl_mount_network_drives
        ;;

    "Copy SSH Keys")
        wsl_copy_ssh_keys "${user_name}"
        ;;

    "WSL2 Configure DNS")
        configure_dns "${dns_server_1}" "${dns_server_2}"
        ;;

    "Configure Git")
        configure_git "${user_name}"
        ;;

    "Install PowerShell Core")
        install_powershell
        ;;

    "Configure Kali Linux GUI")
        configure_kali_linux_gui
        ;;

    "Quit")
        break
        ;;

    *) echo "$REPLY is not an option" ;;

    esac
done
