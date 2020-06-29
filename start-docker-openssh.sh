#!/bin/bash

echo "#########################################"
echo "## Mount a Docker volume"
echo "#########################################"

docker volume ls

echo -n "Please type in the volume name you want to edit: "

read sourceDockerVolume

if [ -z "$sourceDockerVolume" ]
then
      echo "You did not type in a docker volume name....Exiting."
      return
fi

echo "Please type in a mount target folder on the host to mount the Docker volume to:"
echo -n "Mount point: "

read targetMnt

if [ -z "$targetMnt" ]
then
      echo "You did not type in mount target....Exiting."
      return
fi

echo "Starting Docker container..."
echo "This may take a while, please wait!"

containerId=$(docker run \
  -d --rm \
  --name=openssh-server \
  --hostname=openssh-server \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Berlin \
  -e SUDO_ACCESS=false \
  -e PASSWORD_ACCESS=true \
  -e USER_NAME=myuser \
  -e USER_PASSWORD=changeme  \
  -p 127.0.0.1:2222:2222 \
  -v ${sourceDockerVolume}:/mnt \
  linuxserver/openssh-server
) 

sleep 15s

echo "Now login with password 'changeme'!"

#ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" myuser@127.0.0.1 -p2222

sshfs -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" myuser@127.0.0.1:/mnt ${targetMnt} -p2222

echo "Successfully mounted Docker volume!"
echo
echo "Goto"
echo "    ${targetMnt}"
echo "mount target to see the volume contents." 
echo 
echo "Use"
echo "    umount ${targetMnt}"
echo "to unmount volume."
echo
echo "Use"
echo "    docker stop ${containerId}"
echo "to stop the Docker container."
