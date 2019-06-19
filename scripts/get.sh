#! /bin/bash

while sleep 1; do
    curl http://nomad1.mshome.net:8000 \
        -H 'Host:api.localhost' \
        --silent
done
