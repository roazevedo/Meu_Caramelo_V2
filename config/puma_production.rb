# config/puma_production.rb
# Puma pode servir cada requisição em uma thread de um pool de threads interno.
workers ENV.fetch("WEB_CONCURRENCY") { 2 }
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Especificar o 'port' em que o Puma irá ouvir para receber requisições
port ENV.fetch("PORT") { 8080 }

# Especificar o ambiente
environment ENV.fetch("RAILS_ENV") { "production" }

# Especificar explicitamente para ouvir em todos os endereços IP
bind "tcp://0.0.0.0:8080"

# Configurações para melhor desempenho
preload_app!

# Especificar o arquivo de log
stdout_redirect "/rails/log/puma.stdout.log", "/rails/log/puma.stderr.log", true

# Especificar o pidfile
pidfile "/rails/tmp/pids/puma.pid"

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
