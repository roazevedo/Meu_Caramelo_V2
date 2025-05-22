FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems

RUN apt-get update -qq && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get install -y \
    nodejs \
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

WORKDIR /rails

RUN gem install psych --version "~> 5.0"

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

COPY . .

RUN bundle exec rake assets:precompile RAILS_ENV=production

COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/up || exit 1

CMD ["/rails/bin/docker-entrypoint.sh"]
