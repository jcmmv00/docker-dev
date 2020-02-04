#!/bin/bash

rm .env

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

docker-compose up
