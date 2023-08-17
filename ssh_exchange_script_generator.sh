#!/bin/bash

# this is where the script will go to run interactively. No need to change but If you change it you wil have to run resultant script from that location
SCRIPT_PATH="/root/ssh.sh"

# writes the below to the script
cat << 'EOL' > $SCRIPT_PATH
#!/bin/bash

# Check if ed25519 key exists, if not generate one
if [[ ! -f /root/.ssh/id_ed25519 ]]; then
    ssh-keygen -t ed25519 -f /root/.ssh/id_ed25519 -N ""
fi

# ask user for ip or name of remote server
while [[ -z $remote_server_address ]]; do
    read -p "Please enter the remote server name or IP: " remote_server_address
done

# ask for username (root if another Unraid box)
while [[ -z $remote_server_username ]]; do
    read -p "Please enter the remote server username: " remote_server_username
done

# see if the keys have previously been exchanged
if ssh -o BatchMode=yes -o ConnectTimeout=5 $remote_server_username@$remote_server_address true 2>/dev/null; then
    echo "Keys have already been exchanged. Exiting."
    exit 1
fi

# exchange keys
ssh-copy-id -f -o StrictHostKeyChecking=no -i /root/.ssh/id_ed25519.pub $remote_server_username@$remote_server_address

# fix for the Unraid problem after swapping keys about '"hostfile_replace_entries" failed for /root/.ssh/known_hosts'
ssh-keyscan -H $remote_server_address >> ~/.ssh/known_hosts

echo "Keys successfully exchanged and known_hosts file updated."
EOL

# Make the script executable
chmod +x $SCRIPT_PATH

# Confirmation
cat << "EOF"
#  `````````````````````````````````````````````````````````````
#  `````````````````````````````````````````````````````````````
#  ```SSSSSSSSSSSSSSS````SSSSSSSSSSSSSSS`HHHHHHHHH`````HHHHHHHHH
#  `SS:::::::::::::::S`SS:::::::::::::::SH:::::::H`````H:::::::H
#  S:::::SSSSSS::::::SS:::::SSSSSS::::::SH:::::::H`````H:::::::H
#  S:::::S`````SSSSSSSS:::::S`````SSSSSSSHH::::::H`````H::::::HH
#  S:::::S````````````S:::::S``````````````H:::::H`````H:::::H``
#  S:::::S````````````S:::::S``````````````H:::::H`````H:::::H``
#  `S::::SSSS``````````S::::SSSS```````````H::::::HHHHH::::::H``
#  ``SS::::::SSSSS``````SS::::::SSSSS``````H:::::::::::::::::H``
#  ````SSS::::::::SS``````SSS::::::::SS````H:::::::::::::::::H``
#  ```````SSSSSS::::S````````SSSSSS::::S```H::::::HHHHH::::::H``
#  ````````````S:::::S````````````S:::::S``H:::::H`````H:::::H``
#  ````````````S:::::S````````````S:::::S``H:::::H`````H:::::H``
#  SSSSSSS`````S:::::SSSSSSSS`````S:::::SHH::::::H`````H::::::HH
#  S::::::SSSSSS:::::SS::::::SSSSSS:::::SH:::::::H`````H:::::::H
#  S:::::::::::::::SS`S:::::::::::::::SS`H:::::::H`````H:::::::H
#  `SSSSSSSSSSSSSSS````SSSSSSSSSSSSSSS```HHHHHHHHH`````HHHHHHHHH
#  `````````````````````````````````````````````````````````````
#  ``````````````KEY EXCHANGE SCRIPT GENERATED`````````````````
#  `````````````````````````````````````````````````````````````
#  ``````To use open a TERMINAL window in UNRAID WebUI``````````
#  `````````````````````````````````````````````````````````````
#  ````Type ./ssh.sh (NOTE the dot before the forward slash)````
EOF

