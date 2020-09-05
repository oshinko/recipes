FROM ruby:2.7.1
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs yarn
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
RUN test -n "$RAILS_ENV" && test -n "$RAILS_MASTER_KEY" && \
  bundle exec rails assets:precompile RAILS_ENV=$RAILS_ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY && \
  yarn cache clean && \
  yarn install --check-files && \
  bundle exec rails db:migrate RAILS_ENV=$RAILS_ENV
CMD bundle exec puma
