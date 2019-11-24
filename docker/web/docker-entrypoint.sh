#!/bin/bash

if [ -z "$USER_ID" ]; then
  echo "USER_ID variable is not defined."
  exit 1;
fi

if [ -z "$GROUP_ID" ]; then
  echo "GROUP_ID variable is not defined."
  exit 1;
fi

getent passwd $USER_ID > /dev/null
user_result=$?
getent group $GROUP_ID > /dev/null
group_result=$?
grep docker.host.internal /etc/hosts > /dev/null
hosts_result=$?
ping -c 1 docker.for.mac.host.internal > /dev/null
use_mac_result=$?

set -e

# User settings
USER=$USER_ID
unset USER_ID
GROUP=$GROUP_ID
unset GROUP_ID
if [ $user_result -ne 0 ]; then
  echo "docker:x:$USER:$GROUP:docker:/home/docker:/bin/bash" >> /etc/passwd
fi
if [ $group_result -ne 0 ]; then
  echo "docker:x:$GROUP:" >> /etc/group
fi
echo "docker ALL=NOPASSWD: ALL" > /etc/sudoers.d/docker

# Directories settings
chown $USER:$GROUP /home/docker
if [ ! -e /home/docker/.spring ]; then
  mkdir /home/docker/.spring
  chown $USER:$GROUP /home/docker/.spring
fi

# Hosts settings
if [ $hosts_result -ne 0 ]; then
  if [ $use_mac_result -eq 0 ]; then
    # for Mac
    DOCKER_HOST_IP=`ping -c 1 docker.for.mac.host.internal | head -n 2 | tail -n 1 | awk '{print $4}'`
  else
    # for Linux
    DOCKER_HOST_IP=`cat /etc/hosts | awk 'END{print $1}' | sed -r -e 's/[0-9]+$/1/g'`
  fi
  echo ${DOCKER_HOST_IP} docker.host.internal >> /etc/hosts
fi

# Exec
exec gosu $USER:$GROUP "$@"
