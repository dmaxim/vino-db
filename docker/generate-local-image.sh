#!/bin/bash

SA_PASSWORD=""
APP_USER_PASSWORD=""

echo "Building Image"

docker build -t mxinfo.veritas.dbtemp:latest .

echo "Running Image"

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=$SA_PASSWORD" -p 50001:1433 --name mxinfo.veritas.temp -d mxinfo.veritas.dbtemp:latest

echo "Initializing Database"

docker exec mxinfo.veritas.temp sh -c "/opt/scripts/initialize.sh '$SA_PASSWORD' '$APP_USER_PASSWORD'"

echo "Generating Final Image"

docker commit mxinfo.veritas.temp dmaxim/mxinfo.veritas.database:v1.0

echo "Tear down intermediate containers"

docker stop mxinfo.veritas.temp

docker rm mxinfo.veritas.temp
