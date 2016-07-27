FROM ruby:2.3.1-alpine
MAINTAINER ShopKeep Developers <developers@shopkeep.com>

RUN mkdir -p /usr/src/app


# install build/runtime dependencies inside the container
RUN apk add --no-cache make curl-dev ruby-dev build-base

# copy the application source into the container
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install --jobs 4

ENTRYPOINT ["bundle", "exec", "bin/ganbaru"]
