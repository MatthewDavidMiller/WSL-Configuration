#!/bin/bash

# Environment Variables
dns_server_1='8.8.8.8'
dns_server_2='1.1.1.1'
user_name='name'
# Git username
git_name='name'
# Email address
email='email@email.com'
# SSH key location
key_location='location'
# SSH key filename
key='github_ssh'
network_drive='/mnt/share_name'

# Arrays

drives_to_mount=(
    'sudo mount -t drvfs D: /mnt/share_name'
)

aliases=
(
    '# Aliases'
    "alias test=\"an alias\""
)

ssh_keys=
(
    '/mnt/share/key_name'
    '/mnt/share/key_name_2'
)
