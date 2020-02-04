#!/bin/bash

rm .env
DOCKER_USER=asesoftware
DOCKER_PASS=jm1gY4PQhYUdG4j5byoXjk=mrrCR05IO
DOCKER_HOST=asesoftware.azurecr.io

mkdir maven.m2
cd maven.m2
billetera_web_maven_m2_path=$PWD
cd ..
echo "billetera_web_maven_m2_path="$billetera_web_maven_m2_path >> .env

mkdir mysources
cd mysources
billetera_web_my_sources_path=$PWD
cd ..
echo "billetera_web_my_sources_path="$billetera_web_my_sources_path >> .env

mkdir target
cd target
billetera_web_target_path=$PWD
cd ..
echo "billetera_web_target_path="$billetera_web_target_path >> .env

docker login --username=$DOCKER_USER --password=$DOCKER_PASS $DOCKER_HOST

docker-compose up
