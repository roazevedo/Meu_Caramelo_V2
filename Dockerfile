FROM ruby:3.1.4-slim

ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/gems \
    SECRET_KEY_BASE=dummysecretkeyduringbuild

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libv8-dev \
    pkg-config \
    python3 \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

COPY . .

RUN bundle exec rake assets:precompile RAILS_ENV=production

COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

EXPOSE 8080

CMD ["/rails/bin/docker-entrypoint.sh"]
