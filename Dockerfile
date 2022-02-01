FROM ruby:3.0.3

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN \
  gem update --system --quiet && \
  gem install  bundler -v '~> 2.1'
ENV BUNDLER_VERSION 2.1
RUN bundle install

COPY . .

EXPOSE 3000

ENTRYPOINT ["bash", "./config/docker/startup.sh"]