#!/bin/bash
dpkg -i *.deb
systemctl enable docker && systemctl restart docker
docker -v