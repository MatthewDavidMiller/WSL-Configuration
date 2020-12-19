#!/bin/bash

PS3='Select Configuration Option: '
options=(
    "Configure Debian"
    "Configure Kali Linux"
    "Configure Arch Linux"
    "Quit"
)

select options_select in "${options[@]}"; do
    case $options_select in

    "Configure Debian")
        wget -O 'wsl_scripts/debian_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts/debian_options.sh'
        source 'wsl_scripts/debian_options.sh'
        ;;

    "Configure Kali Linux")
        wget -O 'wsl_scripts/kali_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts/kali_options.sh'
        source 'wsl_scripts/kali_options.sh'
        ;;

    "Configure Arch Linux")
        wget -O 'wsl_scripts/arch_linux_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/wsl_scripts/arch_linux_options.sh'
        source 'wsl_scripts/arch_linux_options.sh'
        ;;

    "Quit")
        break
        ;;

    *) echo "$REPLY is not an option" ;;

    esac
done
