FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems \
    NODE_ENV=production \
    PORT=3000

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

RUN mkdir -p tmp/pids

# Copia Gemfiles
COPY Gemfile Gemfile.lock ./

# Desabilita o modo frozen e instala gems
RUN bundle config set frozen false && \
    bundle install --jobs 20 --retry 5

# Copia o resto da aplicação
COPY . .

# Setup dos scripts de entrada
COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

EXPOSE 3000

# Remover HEALTHCHECK - Fly.io usa seu próprio sistema

ENTRYPOINT ["/rails/bin/docker-entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
