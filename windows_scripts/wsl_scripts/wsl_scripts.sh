#!/bin/bash

# Copyright (c) Matthew David Miller. All rights reserved.
# Licensed under the MIT License.

# Compilation of functions for Windows Subsystem for Linux.

function wsl_setup_gui() {
    # Parameters
    local user_name=${1}

    grep -q -E ".*export DISPLAY=localhost:0\.0" "/home/${user_name}/.bashrc" && sed -i -E "s,.*export DISPLAY=localhost:0\.0.*,export DISPLAY=localhost:0\.0," "/home/${user_name}/.bashrc" || printf '%s\n' 'export DISPLAY=localhost:0.0' >>"/home/${user_name}/.bashrc"
}

function wsl_configure_bashrc() {
    # Parameters
    local user_name=${1}
    local aliases

    mapfile -t aliases <'wsl_scripts/aliases.txt'
    grep -q "${drive_to_mount}" "/home/${user_name}/.bashrc" || printf '%s\n' "${drive_to_mount}" >>"/home/${user_name}/.bashrc"

    for i in "${aliases[@]}"; do
        grep -q "$i" "/home/${user_name}/.bashrc" || printf '%s\n' "$i" >>"/home/${user_name}/.bashrc"
    done

}

function wsl_mount_network_drives() {
    mkdir "${network_drive}"
    mount -t drvfs N: "${network_drive}"
}

function wsl_copy_ssh_keys() {
    # Parameters
    local user_name=${1}
    local ssh_keys

    mapfile -t ssh_keys <'wsl_scripts/ssh_keys.txt'

    mkdir -p "/home/${user_name}/.ssh"
    chown "${user_name}" "/home/${user_name}/.ssh"
    chmod 700 "/home/$user_name/.ssh"
    touch "/home/$user_name/.ssh/authorized_keys"
    chmod 600 "/home/$user_name/.ssh/authorized_keys"

    for i in "${ssh_keys[@]}"; do
        cp "$i" "/home/${user_name}/.ssh/"
    done
}

function wsl_install_packages_debian() {

    mapfile -t debian_packages <'wsl_scripts/debian_packages.txt'

    apt-get update
    apt-get upgrade -y
    for i in "${debian_packages[@]}"; do
        apt-get install -y $i
    done
}

function configure_git() {
    # Parameters
    local user_name=${1}

    # Setup username
    git config --global user.name "${git_name}"

    # Setup email
    git config --global user.email "${email}"

    # Setup ssh key
    mkdir -p "/home/${user_name}/.ssh"
    chmod 700 "/home/${user_name}/.ssh"
    cp "${key_location}" "/home/${user_name}/.ssh/${key}"
    chmod 700 "/home/${user_name}/.ssh/${key}"
    chown "${user_name}" "/home/${user_name}/.ssh/${key}"
    git config --global core.sshCommand "ssh -i ""/home/${user_name}/.ssh/${key}"" -F /dev/null"
}

function configure_dns() {
    # Parameters
    local dns_server_1=${1}
    local dns_server_2=${2}

    # Add dns servers to resolv.conf
    grep -q -E ".*nameserver ${dns_server_1}" '/etc/resolv.conf' && sed -i -E "s,.*nameserver ${dns_server_1}.*,nameserver ${dns_server_1}," '/etc/resolv.conf' || printf '%s\n' "nameserver ${dns_server_1}" >>'/etc/resolv.conf'
    grep -q -E ".*nameserver ${dns_server_2}" '/etc/resolv.conf' && sed -i -E "s,.*nameserver ${dns_server_2}.*,nameserver ${dns_server_2}," '/etc/resolv.conf' || printf '%s\n' "nameserver ${dns_server_2}" >>'/etc/resolv.conf'

    # Make resolv.conf read only
    chmod 444 '/etc/resolv.conf'

    # Turn off WSL autogenerated resolv.conf
    cat <<EOF >>'/etc/wsl.conf'
[network]
generateResolvConf = false

EOF

    # Set wsl.conf permissions
    chmod 744 '/etc/wsl.conf'
}

function install_powershell_debian() {
    # Download and register Microsoft repository GPG keys
    wget 'https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb'
    dpkg -i packages-microsoft-prod.deb

    apt-get update
    apt-get install -y powershell
}

function configure_kali_linux_gui() {
    apt-get update
    apt-get install -y kali-win-kex dbus-x11
}

function wsl_install_packages_kali() {
    mapfile -t kali_packages <'wsl_scripts/kali_packages.txt'

    apt-get update
    apt-get upgrade -y
    for i in "${kali_packages[@]}"; do
        apt-get install -y $i
    done
}

function wsl_install_packages_arch() {
    mapfile -t arch_packages <'wsl_scripts/arch_packages.txt'

    pacman -Syu
    for i in "${arch_packages[@]}"; do
        pacman -S --noconfirm --needed $i
    done
}

function arch_initialize_keyring() {
    pacman-key --init
    pacman-key --populate
}

function wsl2_setup_gui() {
    # Credits to Surya Raj, https://medium.com/@surya.raj/how-to-use-gui-applications-in-wsl-wsl2-distros-using-vcxsrv-5a10eef14073

    # Parameters
    local user_name=${1}

    printf '%s\n' "export DISPLAY=\$(ip route get 8.8.8.8 | sed -nr 's/.*src ([^\ ]+).*/\1/p'):0" >>"/home/${user_name}/.bashrc"
}