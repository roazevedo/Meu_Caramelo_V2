#!/bin/bash
set -e

# Precompila assets se necessário
if [ ! -d "public/assets" ]; then
  echo "Precompiling assets..."
  bundle exec rake assets:precompile RAILS_ENV=production
fi

# Resto do seu script...
exec "$@"
