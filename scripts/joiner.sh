#!/bin/bash

# hack to add a new joiner

for id in $(seq 1 10); do
    DIRECTORY="/home/jkrauska/testfu/test-joiner-${id}"
    if [ ! -d "$DIRECTORY" ]; then
        mkdir ${DIRECTORY}
        base=$(expr $id \* 10)
        cp=$(expr 8900 + $base + 1)
        ep=$(expr 8900 + $base + 2)
        rp=$(expr 8900 + $base + 4)

        echo "{\"external-port\": ${ep}, \"rest-port\": ${rp} }" > ${DIRECTORY}/daemon.json
        coda daemon -background -ip 127.0.0.1 -client-port ${cp} -config-directory ${DIRECTORY} -tracing  -peer 127.0.0.1:8303

        # only run once.
        break
    fi
done