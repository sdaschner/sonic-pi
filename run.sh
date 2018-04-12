#!/bin/bash

cmd=${1:-"/bin/bash"}

docker run -ti \
    -p 4558:4558 -p 4557:4557 -p 4556:4556 -p 4559:4559 -p 4560:4560 -p 4561:4561 -p 4562:4562 \
    --network dkrnet \
    --ip 192.168.42.2 \
    sonicpi-server $cmd
