FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems \
    BUNDLE_BUILD__MINI_RACER="--with-v8-dir=/usr/local" \
    MAKE="make -j$(nproc)"

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
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Instala Node.js direto do site oficial (versão 18.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# Atualiza o bundler e instala psych com versão específica
RUN gem update --system && \
    gem install bundler -v 2.5.5 && \
    gem install psych --version "~> 5.0"

# Copia Gemfiles e instala gems
COPY Gemfile Gemfile.lock ./

# Configura bundler para mini_racer e instala gems
RUN bundle config set --local build.mini_racer "--with-v8-dir=/usr/local" && \
    bundle install --jobs 20 --retry 5

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
