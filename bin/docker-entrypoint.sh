#!/bin/bash
set -e

# Espera o banco de dados estar disponível (opcional, mas recomendado)
# Você pode personalizar o comando abaixo para seu banco, por exemplo PostgreSQL:
if [ "$WAIT_FOR_DB" = "true" ]; then
  echo "Waiting for database..."
  until pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USERNAME; do
    sleep 1
  done
fi

# Executa as migrações no startup (caso queira rodar automaticamente)
echo "Running database migrations..."
bundle exec rake db:migrate

# Inicia o servidor Rails na porta definida por $PORT ou padrão 8080
echo "Starting Rails server..."
exec bundle exec puma -C config/puma.rb -p ${PORT:-8080}

