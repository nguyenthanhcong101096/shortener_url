FROM ruby:3.0.4

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev

ENV APP_DIR /shortener_url
ENV BUNDLE_PATH /shortener_url/bundle

RUN mkdir $APP_DIR

WORKDIR $APP_DIR

COPY Gemfile Gemfile.lock ./

RUN bundle install

# RUN gem install bundler:2.3.12

COPY . .

RUN EDITOR="mate --wait" bundle exec rails credentials:edit

RUN chmod u+x $APP_DIR/rails.sh

EXPOSE 3000
