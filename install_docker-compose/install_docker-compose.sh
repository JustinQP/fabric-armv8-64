#!/bin/bash
tar -xvf docker-compose-aarch64.tar.gz -C /usr/local/bin/
cd /usr/local/bin/
chmod a+x docker-compose
docker-compose -version