max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 2 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port ENV.fetch("PORT") { 8080 }

environment ENV.fetch("RAILS_ENV") { "production" }

workers ENV.fetch("WEB_CONCURRENCY") { 1 }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

bind "tcp://0.0.0.0:#{ENV.fetch("PORT") { 8080 }}"

preload_app!

plugin :tmp_restart
