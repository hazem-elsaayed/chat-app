FROM ruby:2.6.8

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN \
  gem update --system --quiet && \
  gem install  bundler -v '~> 1.17.2'
ENV BUNDLER_VERSION 1.17.2
RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["bash", "./config/docker/startup.sh"]