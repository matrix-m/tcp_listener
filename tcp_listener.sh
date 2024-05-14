#!/bin/bash

echo "Enter the port number to listen on: "
read port
echo "Listening on port $port..."

while true ; do
    connection=$(nc -lv $port)
    client_ip=$(echo $connection | awk '{print $4}')
    client_port=$(echo $connection | awk '{print $5}')
done
