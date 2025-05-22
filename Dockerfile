FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems \
    NODE_ENV=production

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js (necessário para terser e assets)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# Copia Gemfiles
COPY Gemfile Gemfile.lock ./

# Desabilita o modo frozen e instala gems
RUN bundle config set frozen false && \
    bundle install --jobs 20 --retry 5

# Copia o resto da aplicação
COPY . .

# Verifica se temos JavaScript runtime disponível e precompila assets
RUN echo "Node.js version: $(node --version)" && \
    echo "NPM version: $(npm --version)" && \
    bundle exec rails runner "puts 'Rails loaded successfully'" && \
    bundle exec rake assets:precompile RAILS_ENV=production RAILS_GROUPS=assets

# Setup dos scripts de entrada
COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/up || exit 1

CMD ["/rails/bin/docker-entrypoint.sh"]
