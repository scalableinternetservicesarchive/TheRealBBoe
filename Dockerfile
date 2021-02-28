FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install -y nodejs yarn --no-install-recommends \
  && yarn add @fortawesome/fontawesome-free \  
  && yarn add @fortawesome/free-solid-svg-icons \
  && gem install bundler \
  && gem install rails

WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

CMD ["/bin/bash"]
