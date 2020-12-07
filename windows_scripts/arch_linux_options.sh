#!/bin/bash

PS3='Select Configuration Option: '
options=("Install Packages Arch" "WSL Version 1 Setup GUI" "Configure Bashrc" "Mount Network Drives" "Copy SSH Keys" "WSL2 Configure DNS" "Configure Git" "Install PowerShell Core" "Quit")

select options_select in "${options[@]}"; do
    case $options_select in

    "Install Packages Arch")
        wsl_install_packages_arch
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
        install_powershell_arch
        ;;

    "Quit")
        break
        ;;

    *) echo "$REPLY is not an option" ;;

    esac
done
