#!/bin/sh -ex

# add all our dependencies
DEBS='python-setuptools make graphviz'
apt-get update
apt-get install -y $DEBS
easy_install pip
pip install --no-cache-dir -r /projects/project/requirements.txt

# build the content and put it where nginx expects
make html
mv build/html/* /usr/share/nginx/html/
make clean

# remove unnecessary dependencies
pip freeze | xargs pip uninstall -y

apt-get autoremove -y --purge $DEBS

rm -rf /var/cache/apk/*
