set -e
set -x

tag=16.04

docker build -t brainlife/ui-fsleyes . 
docker tag brainlife/ui-fsleyes brainlife/ui-fsleyes:$tag
docker push brainlife/ui-fsleyes

