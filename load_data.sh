#!/bin/sh

#
# Load Mongo data
cd ~/Desktop/source/
mongorestore -h 127.0.0.1 --port 3001 -d meteor dump/