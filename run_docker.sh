#!/bin/bash
export DISPLAY=:0
export UID=$(id -u)
export USER=$(whoami)
export HOME=/home/$USER

# xhost + # enalbe X11 forwarding
# sudo compose up

