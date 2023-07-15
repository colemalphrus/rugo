FROM ruby:3.2.1

RUN apt-get update -qq && \
    apt-get install -y build-essential libssl-dev nodejs less vim nano libsasl2-dev

RUN mkdir /usr/rugo
WORKDIR /usr/src/
COPY . .
COPY ./rugo /usr/rugo
WORKDIR /usr/rugo/
RUN gem build rugo.gemspec
RUN gem install rugo-*.gem

WORKDIR /usr/src/demo

RUN bundle install


EXPOSE 3000

ENTRYPOINT rake s