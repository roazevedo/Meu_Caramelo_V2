# Puma pode servir cada requisição em um thread de um conjunto de threads.
# Os valores padrão são mostrados abaixo.
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Especifica a porta em que o servidor Puma vai escutar
port ENV.fetch("PORT") { 8080 }

# Especifica o ambiente do servidor
environment ENV.fetch("RAILS_ENV") { "development" }

# Especifica o número de processos para usar
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use o mesmo diretório para persistir estado do servidor
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Certifique-se de escutar em todos os endereços IP disponíveis
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 8080 }}"

# Permite que o Puma seja reiniciado por `rails restart` command
plugin :tmp_restart
