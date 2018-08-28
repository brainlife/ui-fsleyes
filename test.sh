echo "running vnc server"
docker stop test
docker rm test

password=$RANDOM.$RANDOM.$RANDOM
echo "password: $password"

id=$(docker run -dP --name test -e X11VNC_PASSWORD=$password -v `pwd`/test:/input:ro brainlife/ui-fsleyes)
hostport=$(docker port $id | cut -d " " -f 3)
echo "container $id using $hostport"

WEBSOCK_PORT=0.0.0.0:11000

echo "------------------------------------------------------------------------"
echo "http://dev1.soichi.us:11000/vnc_lite.html?password=$password"
echo "------------------------------------------------------------------------"

/usr/local/noVNC/utils/launch.sh --listen $WEBSOCK_PORT --vnc $hostport


