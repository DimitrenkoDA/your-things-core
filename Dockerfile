FROM ruby:2.6.5-alpine as builder
RUN apk add --update g++ git make postgresql-dev && gem install --no-document bundler
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle config set deployment 'true'
RUN bundle config path vendor/bundle
RUN bundle install

FROM ruby:2.6.5-alpine
RUN gem install --no-document bundler && apk add --update postgresql-dev
COPY . /app/
COPY --from=builder /app/vendor/bundle /app/vendor/bundle
WORKDIR /app
RUN bundle config path vendor/bundle
CMD ["bundle", "exec", "puma", "--config", "/app/config/puma.rb"]
