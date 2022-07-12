# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.2'

# Use Puma as the app server
# http://puma.io
gem 'puma'

# Rack middleware for handling CORS
# https://github.com/cyu/rack-cors
gem 'rack-cors', require: 'rack/cors'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap'

# Rack middleware for blocking & throttling
# https://github.com/kickstarter/rack-attack
gem 'rack-attack'

# Build JSON APIs with ease
# https://github.com/rails/jbuilder
gem 'jbuilder'

# Pry as rails console
# https://github.com/rweng/pry-rails
gem 'pry-rails'

group :production do
  # Direct logs to STDOUT
  # https://github.com/heroku/rails_12factor
  gem 'rails_12factor'
end

group :development, :test do
  # Static code analyzer
  # https://github.com/bbatsov/rubocop
  gem 'rubocop'
  gem 'rubocop-performance'

  # Gem vulnerability checker
  # https://github.com/appfolio/gemsurance
  gem 'gemsurance'

  # Static analysis security scanner for Ruby on Rails
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman'

  # A Ruby gem to load environment variables from `.env`.
  gem 'dotenv-rails'

  # factory_bot is a fixtures replacement with a straightforward definition syntax
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails'

  # Brings the RSpec testing framework to RoR as a drop-in alternative to its default testing framework
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails'

  # Code coverage for Ruby
  # https://github.com/colszowka/simplecov
  gem 'simplecov'
end

group :development do
  # Provides iteration per second benchmarking for Ruby
  # https://github.com/evanphx/benchmark-ips
  gem 'benchmark-ips'

  # Adds step-by-step debugging and stack navigation capabilities to pry using byebug.
  # https://github.com/deivid-rodriguez/pry-byebug
  gem 'pry-byebug'

  # The Listen gem listens to file modifications and notifies you about the changes
  # https://github.com/guard/listen
  gem 'listen'
end
