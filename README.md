# Unraid SSH Key Exchange Script

This script is designed to streamline the process of exchanging SSH keys between an Unraid server and other computers or servers. It is particularly helpful for users new to Unraid or command line interfaces, making the process simpler and more intuitive.

## Overview

Using SSH keys provides a safer way to log into a server compared to password-based authentication. With SSH keys, users can authenticate and access a server without the need for a password. Our script not only facilitates the generation and exchange of these keys but also addresses some quirks unique to Unraid.

## Prerequisites

- **Unraid User Scripts Plugin**: Before using this script, ensure you have the Unraid User Scripts plugin installed on your Unraid server.

## How to Use

### 1. Set Up the Script on Unraid

- **Copy the Script**: First, get a copy of our key exchange script. This can be done by copying the script directly from this repository.
  
- **Paste into Unraid User Scripts**: Navigate to the Unraid web interface and find the User Scripts plugin. Create a new script and paste the copied key exchange script into it.

### 2. Run the Script via User Scripts

Execute the script using the User Scripts interface. This will generate an interactive script and place it on your Unraid server.

### 3. Execute the Generated Interactive Script

- **Run in Terminal**: Open a terminal window in the Unraid web interface.

- **Run the Script**: 
  ```bash
  ./ssh.sh

- **Provide Server Details**: The script will prompt you for:
  - The remote server's address (e.g., its IP).
  - The username for the remote server.

- **Authentication**: It will then request the password for the remote server.

- **Key Exchange**: Once the details are provided, the script will exchange SSH keys with the remote server, ensuring a secure connection.

- **Addressing Unraid's Quirk**: The script will also run `ssh-keyscan` to tackle a known Unraid issue: '"hostfile_replace_entries" failed for /root/.ssh/known_hosts'.

- **Completion**: After these steps, you'll be able to securely log into the remote server without needing a password.
