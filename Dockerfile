FROM ruby:3.2.2

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential apt-utils libpq-dev nodejs \
    curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

WORKDIR /space-travel

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /space-travel

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD ["/bin/bash -l -c \"chmod +x boot.sh && ./boot.sh\""]
