#!/bin/bash

if [ ! -d "frontend" ]
then
    wget https://github.com/CodyHouse/codyhouse-framework/archive/master.zip && unzip master.zip
    mv codyhouse-framework-master frontend
    rm master.zip
    sed -i -e "s/var scriptsJsPath = 'main\/assets\/js';/var scriptsJsPath = '..\/cms\/static\/js';/g" frontend/gulpfile.js
    sed -i -e "s/var cssFolder = 'main\/assets\/css';/var cssFolder = '..\/cms\/static\/css';/g" frontend/gulpfile.js
    # cd frontend && npm install
else
    echo "EXITED: already run"
fi