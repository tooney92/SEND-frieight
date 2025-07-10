# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "~> 7.2.1"
gem "mysql2", ">= 0.5.5"
gem "puma", "~> 6.0"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "bootsnap", require: false
gem "rack-cors"
gem "solid_queue"
gem 'kaminari'


group :development, :test do
  gem "dotenv-rails"
  gem "pry-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "shoulda-matchers", "~> 6.0"
  gem "rspec-rails"
  gem 'bullet'
end


group :development do
  gem "listen", "~> 3.3"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "bullet"
end
