# docker-volume-sshfs
Script to start an OpenSSH server in a Docker container to mount a Docker volume in the host's filesystem.

## Prerequisites

Make sure your host has SSHFS installed. You can install SSHFS with
```
sudo apt-get install sshfs
```

This script uses the OpenSSH server container from linuxserver available at https://hub.docker.com/r/linuxserver/openssh-server.

## How to use

Start the script and type in the information the script needs like the name of the Docker volume to mount, the target mount point in the host system. The script lists all available Docker volumes before prompting. 

After the script finished successfully, change the directory to see the desired mount point.
