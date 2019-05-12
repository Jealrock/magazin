FROM ruby:2.5.5
RUN apt-get update && \
    apt-get install -y openssh-client build-essential wget git-core libssl-dev libxml2 libxml2-dev libxslt1-dev imagemagick libmagickcore-dev libmagickwand-dev libpq-dev && \
    (curl -sS https://deb.nodesource.com/setup_9.x | bash -) && \
    (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -) && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT
# Set working directory
WORKDIR $RAILS_ROOT
# Setting env up
ENV NODE_ENV production
ENV RAILS_ENV production
ENV RACK_ENV production
# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN bundle install --jobs 20 --retry 5 --without development test
# Adding project files
COPY . .
RUN bundle exec yarn install
RUN bundle exec rake assets:precompile
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
