FROM ruby:3.2.2-slim

# Instalar dependências
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm git
RUN npm install -g yarn

# Criar diretório da aplicação
WORKDIR /rails

# Instalar gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5

# Copiar a aplicação
COPY . .

# Precompilar assets
RUN bundle exec rake assets:precompile RAILS_ENV=production

# Script de entrada
COPY ./bin/docker-entrypoint.sh /rails/bin/docker-entrypoint.sh
RUN chmod +x /rails/bin/docker-entrypoint.sh

# Criar link simbólico para o script fly-entrypoint
RUN ln -s /rails/bin/docker-entrypoint.sh /rails/bin/fly-entrypoint && \
    chmod +x /rails/bin/fly-entrypoint

# Expor a porta
EXPOSE 8080

# Comando de inicialização
CMD ["/rails/bin/docker-entrypoint.sh"]
