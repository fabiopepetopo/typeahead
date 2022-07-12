# This ruby version should match with the one
# declared in your Gemfile and Gemfile.lock files
FROM ruby:2.7.1-alpine

# Minimal needed packages to add to alpine image to make Rails work
RUN apk add --no-cache build-base sqlite sqlite-dev sqlite-libs tzdata git

# Port configuration. Rails will automatically use PORT env var to choose the port
ENV PORT 12345
EXPOSE $PORT

WORKDIR /usr/src/app

# Just copying these two files to install dependencies. This layer with dependencies
# will get cached, so even when app code changes, we won't need to re-create this layer
COPY Gemfile Gemfile.lock ./

RUN bundle install

# Copy the rest of the app's code
COPY . .

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]