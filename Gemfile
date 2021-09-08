# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :development do
  gem 'capistrano-rails', '~> 1.4.0', require: false
  gem 'capistrano-rbenv', '~> 2.1.4', require: false
  gem 'capistrano-nodenv', '~> 1.1.0', require: false
  gem 'capistrano-bundler', '~> 1.6.0', require: false
end

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'brakeman', '~> 4.7.2', require: false
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'rspec-its', '~> 1.3.0', require: false
  gem 'rspec-rails', '~> 3.9.0'
  gem 'rspec_junit_formatter', '~> 0.4.1', require: false
  gem 'rubocop', '~> 0.77.0', require: false
  gem 'rubocop-performance', '~> 1.5.1', require: false
  gem 'rubocop-rails', '~>2.4.0', require: false
  gem 'scss_lint', '~> 0.59.0', require: false
  gem 'shoulda-callback-matchers', '~> 1.1.4', require: false
  gem 'shoulda-matchers', '~> 4.1.2', require: false
  gem 'simplecov', '~> 0.17.1', require: false
  gem 'simplecov-console', '~> 0.6.0', require: false
  gem 'slim_lint', '~> 0.18.0', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'web-console', '>= 3.7.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'awesome_print', '~> 1.8'
  gem 'better_errors', '~> 2.8'
  gem 'binding_of_caller', '~> 0.8.0'
  gem 'bullet', '~> 6.0.2'
  gem 'letter_opener_web', '~> 1.3.1'
  gem 'pry-byebug', '~> 3.7.0'
  gem 'pry-coolline', '~> 0.2.5'
  gem 'pry-doc', '~> 1.0.0'
  gem 'pry-rails', '~> 0.3.6'
  gem 'pry-stack_explorer', '~> 0.4.9.2'
  gem 'annotate', '~> 3.0.3'
  gem 'rails-erd', '~> 1.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# App server
gem 'puma_worker_killer', '~> 0.1.1'

# Logger
gem 'chrono_logger', '~> 1.1.1'

# Configuration
gem 'dotenv-rails', '~> 2.7.5'
gem 'settingslogic', '~> 2.0.9'

# Locale
gem 'devise-i18n', '~> 1.8.2'
gem 'doorkeeper-i18n', '~> 5.2'
gem 'rails-i18n', '~> 5.1.1'

# Authentication
gem 'devise', '~> 4.7.1'

# ActiveRecord
gem 'enumerize', '~> 2.3.1'
gem 'kaminari', '~> 1.1.1'
gem 'ransack', '~> 2.3.0'
gem 'active_model_serializers', '~> 0.10.10'

# ActionView
gem 'slim-rails', '~> 3.2.0'

# Redis
gem 'hiredis', '~> 0.6.1'
gem 'redis-namespace', '~> 1.6.0'
gem 'redis-rails', '~> 5.0.2'

# CORS
gem 'rack-cors', '~> 1.1.0', require: 'rack/cors'

# OAuth2 provider
gem 'doorkeeper', '~> 5.2.2'

# API
gem 'problem_details-rails', '~> 0.2.2'
gem 'graphql', '~> 1.11.6'
gem 'graphql-batch', '~> 0.4.3'
