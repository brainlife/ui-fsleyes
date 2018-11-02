#!/bin/bash

echo "running vnc server"
docker stop test
docker rm test

set -e
set -x

password=$RANDOM.$RANDOM.$RANDOM
echo "password: $password"

#echo "disabling xserver access control"
#xhost +

id=$(docker run -dP --runtime=nvidia -e LD_LIBRARY_PATH=/usr/lib/nvidia -v /usr/lib/nvidia-410.72:/usr/lib/nvidia:ro -v /tmp/.X11-unix:/tmp/.X11-unix:ro --name test -e X11VNC_PASSWORD=$password -v `pwd`/test:/input:ro brainlife/ui-fsleyes:16.04)
hostport=$(docker port $id | cut -d " " -f 3)
echo "container $id using $hostport"

PORT=11020
hostname=$(hostname)

echo "------------------------------------------------------------------------"
echo "http://$hostname:$PORT/vnc_lite.html?password=$password"
echo "------------------------------------------------------------------------"

/usr/local/noVNC/utils/launch.sh --listen 0.0.0.0:$PORT --vnc $hostport


