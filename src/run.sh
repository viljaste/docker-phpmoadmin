#!/usr/bin/env bash

MONGODB_PORT="$(echo "${MONGODB_PORT}" | sed 's/tcp:\/\///')"

export FACTER_MONGODB_HOST="$(echo "${MONGODB_PORT}" | cut -d ":" -f1)"
export FACTER_MONGODB_PORT="$(echo "${MONGODB_PORT}" | cut -d ":" -f2)"

if [ -z "${MONGODB_USERNAME}" ]; then
  MONGODB_USERNAME="root"
fi

export FACTER_MONGODB_USERNAME="${MONGODB_USERNAME}"

if [ -z "${MONGODB_PASSWORD}" ]; then
  MONGODB_PASSWORD="root"
fi

export FACTER_MONGODB_PASSWORD="${MONGODB_PASSWORD}"

if [ -z "${SERVER_NAME}" ]; then
  SERVER_NAME="localhost"
fi

export FACTER_SERVER_NAME="${SERVER_NAME}"

puppet apply --modulepath=/src/run/modules /src/run/run.pp

/usr/bin/supervisord
