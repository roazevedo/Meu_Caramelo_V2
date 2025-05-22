FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    libv8-dev \
    clang \
    llvm \
    libc++-dev \
    libc++abi-dev \
    pkg-config \
    python3 \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js direto do site oficial (versão 18.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

RUN gem install psych --version "~> 5.0"

# Copia Gemfiles e instala gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

# Copia restante da aplicação
COPY . .

# Precompila assets, se necessário (opcional)
RUN bundle exec rake assets:precompile RAILS_ENV=production

COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/up || exit 1

CMD ["/rails/bin/docker-entrypoint.sh"]
