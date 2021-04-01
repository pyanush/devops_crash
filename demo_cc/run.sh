#!/bin/bash

docker-compose build
docker-compose up  --force-recreate
#rm -r ./logs ./result
