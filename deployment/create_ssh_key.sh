#!/bin/bash

# Creates a new SSH key for that via installation's main user
# Store your password in the file kjewrfkjhasdfkjhw.txt (which is gitignored, of course)

# Generate key pair
ssh-keygen -b 2048 -t rsa -N "" -f ./files/ssh/via_id

# Encrypt private key and display it for copy/paste into mediaclue YAML file
echo "Copy/paste the following into your via_*.yml file:"
ansible-vault encrypt_string --encrypt-vault-id default --vault-password-file kjewrfkjhasdfkjhw.txt --stdin-name 'sshPrivateKey' < ./files/ssh/via_id

# Delete private key, leave only public key
rm ./files/ssh/via_id
