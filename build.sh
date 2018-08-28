docker build -t brainlife/ui-fsleyes .
if [ $? -eq 0 ]; then
    docker push brainlife/ui-fsleyes
fi
