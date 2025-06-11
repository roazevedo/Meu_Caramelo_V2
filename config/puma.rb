max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 2 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Remover port, usar apenas bind
# port ENV.fetch("PORT") { 3000 }

environment ENV.fetch("RAILS_ENV") { "production" }

# Para aplicações pequenas no Fly.io, considere workers = 0
workers ENV.fetch("WEB_CONCURRENCY") { 1 }

# Adicionar silence_single_worker_warning se usar workers = 0
# silence_single_worker_warning

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Bind correto para Fly.io
bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 3000 }}"

preload_app!

plugin :tmp_restart
