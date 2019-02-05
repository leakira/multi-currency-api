FROM ruby:2.5.3-stretch

RUN apt-get update && apt-get upgrade --yes
RUN gem install bundler
WORKDIR /app

COPY Gemfile .
RUN bundle install && bundle clean
EXPOSE 3000
CMD ["rackup", "config.ru", "-p", "3000"]