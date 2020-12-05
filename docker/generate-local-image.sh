#!/bin/bash

SA_PASSWORD=""
APP_USER_PASSWORD=""

echo "Building Image"

docker build -t mxinfo.veritas.dbtemp:latest .

echo "Running Image"

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$SA_PASSWORD" -p 1934:1433 --name mxinfo.veritas.temp -d mxinfo.veritas.dbtemp:latest

echo "Initializing Database"

docker exec mxinfo.veritas.temp sh -c "/opt/scripts/initialize.sh '$APP_USER_PASSWORD'"

echo "Generating Final Image"

docker commit mxinfo.veritas.temp dmaxim/mxinfo.veritas.database:latest

echo "Tear down intermediate containers"

docker stop mxinfo.veritas.temp

docker rm mxinfo.veritas.temp
