#!/bin/bash

PS3='Select Configuration Option: '
options=(
    "Configure Debian Based Distro"
    "Configure Arch Linux"
    "Quit"
)

select options_select in "${options[@]}"; do
    case $options_select in

    "Configure Debian Based Distro")
        wget -O 'debian_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/debian_options.sh'
        source debian_options.sh
        ;;

    "Configure Arch Linux")
        wget -O 'arch_linux_options.sh' 'https://raw.githubusercontent.com/MatthewDavidMiller/WSL-Configuration/stable/windows_scripts/arch_linux_options.sh'
        source arch_linux_options.sh
        ;;

    *) echo "$REPLY is not an option" ;;

    esac
done
