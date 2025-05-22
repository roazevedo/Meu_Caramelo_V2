FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    pkg-config \
    python3 \
    git \
    libpq-dev \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js (necessário para terser e assets)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# Copia Gemfiles
COPY Gemfile Gemfile.lock ./

# Instala gems com configuração otimizada
RUN bundle config set --local build.mini_racer "--with-v8-dir=/usr/local" && \
    bundle config set --local build.libv8-node "--with-v8-dir=/usr/local" && \
    bundle install --jobs 4 --retry 3

# Copia o resto da aplicação
COPY . .

# Precompila assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

# Setup dos scripts de entrada
COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/up || exit 1

CMD ["/rails/bin/docker-entrypoint.sh"]
