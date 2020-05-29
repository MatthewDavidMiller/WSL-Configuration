#!/bin/bash

# Copyright (c) Matthew David Miller. All rights reserved.
# Licensed under the MIT License.

# Compilation of functions for Windows Subsystem for Linux.

function wsl_setup_gui() {
    # Parameters
    local user_name=${1}

    bash -c "echo export DISPLAY=localhost:0.0" >>"/home/${user_name}/.bashrc"
}

function wsl_configure_bashrc() {
    # Parameters
    local user_name=${1}

    cat <<\EOF >>"/home/${user_name}/.bashrc"

# Mount network drives
sudo mount -t drvfs N: /mnt/matt_files

# Aliases
alias sudo='sudo '
alias ssh_nas="ssh -i '.ssh/nas_key' matthew@matt-nas.miller.lan"
alias ssh_openwrt="ssh -i '.ssh/openwrt_key' matthew@mattopenwrt.miller.lan"
alias ssh_proxmox="ssh -i '.ssh/proxmox_key' matthew@matt-prox.miller.lan"
alias ssh_vpn="ssh -i '.ssh/vpn_key' matthew@matt-vpn.miller.lan"
alias ssh_pihole="ssh -i '.ssh/pihole_key' matthew@matt-pihole.miller.lan"
alias cd_git='cd /mnt/matt_files/Matthew_Cloud/git'

EOF
}

function wsl_mount_network_drives() {
    mkdir /mnt/matt_files
    mount -t drvfs N: /mnt/matt_files
}

function wsl_copy_ssh_keys() {
    # Parameters
    local user_name=${1}

    mkdir -p "/home/${user_name}/.ssh"
    chown "${user_name}" "/home/${user_name}/.ssh"
    chmod 700 "/home/$user_name/.ssh"
    touch "/home/$user_name/.ssh/authorized_keys"
    chmod 600 "/home/$user_name/.ssh/authorized_keys"
    cp '/mnt/matt_files/SSHConfigs/matt_homelab/nas_key' "/home/${user_name}/.ssh/nas_key"
    cp '/mnt/matt_files/SSHConfigs/matt_homelab/openwrt_key' "/home/${user_name}/.ssh/openwrt_key"
    cp '/mnt/matt_files/SSHConfigs/matt_homelab/proxmox_key' "/home/${user_name}/.ssh/proxmox_key"
    cp '/mnt/matt_files/SSHConfigs/matt_homelab/vpn_key' "/home/${user_name}/.ssh/vpn_key"
    cp '/mnt/matt_files/SSHConfigs/matt_homelab/pihole_key' "/home/${user_name}/.ssh/pihole_key"
}

function wsl_install_packages() {
    apt-get update
    apt-get upgrade -y
    apt-get install -y git ssh python3 python-pip wireshark nmap wget shellcheck
}

function wsl_get_username() {
    user_name=$LOGNAME
}

function configure_git() {
    # Parameters
    local user_name=${1}

    # Variables
    # Git username
    git_name='MatthewDavidMiller'
    # Email address
    email='matthewdavidmiller1@gmail.com'
    # SSH key location
    key_location='/mnt/matt_files/SSHConfigs/github/github_ssh'
    # SSH key filename
    key='github_ssh'

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

    # Delete resolv.conf
    rm -f '/etc/resolv.conf'

    cat <<EOF >>'/etc/resolv.conf'
nameserver "${dns_server_1}"
nameserver "${dns_server_2}"

EOF

    # Make resolv.conf read only
    chmod 444 '/etc/resolv.conf'
}
