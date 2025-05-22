#!/bin/bash
set -e

if [ "$WAIT_FOR_DB" = "true" ]; then
  echo "Waiting for database..."
  until pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USERNAME"; do
    sleep 1
  done
fi

echo "Running database migrations..."
bundle exec rake db:migrate

echo "Starting Rails server..."
exec bundle exec puma -C config/puma.rb -p "${PORT:-8080}"
