#!/bin/bash

set -e
LOG="/tmp/docker-services.log"

function initialize_docker_services(){

  # Wait for docker to be running
  while docker info | grep "Containers: 0" > /dev/null; do
    echo "waiting for docker..." >> $LOG
    sleep 0.1;
  done;

  echo "docker is running" >> $LOG

  # This docker-in-docker service is postgres
  # Wait for postgres to be running
  until docker exec postgres pg_isready | grep "accepting connections" > /dev/null; do
    echo "waiting for postgres..." >> $LOG
    sleep 0.1;
  done;

  echo "postgres is running" >> $LOG

  # Here you might initialize your database schema, load some data, etc. For example:
  # docker exec postgres psql -U postgres -c "CREATE TABLE ..."
  # echo "schema initialized" >> $LOG
}

echo "Initializing docker services" >> $LOG
initialize_docker_services & # run in background for quicker startup
exit 0