source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Repository for collecting Locale data for Ruby on Rails I18n as well as other interesting
gem 'rails-i18n', '~> 5.0.0' # For 5.0.x
# Flexible authentication solution for Rails with Warden.
gem 'devise'
#Translations for the devise gem
gem 'devise-i18n'
#Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup.
gem 'simple_form'
#Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "less-rails"
#Twitter Bootstrap for Rails 3.x - 4 Asset Pipeline
gem "twitter-bootstrap-rails"
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# O BrCep é um gem que tem como objetivo buscar um endereço com base no seu CEP.
gem "brcep"
# Classier solution for file uploads for Rails, Sinatra and other Ruby web frameworks
gem 'carrierwave'
# Iugu Intregração Rails 
gem 'iugu'
# FriendlyId allows you to create pretty URL’s and work with human-friendly strings as if they were numeric ids for ActiveRecord models.
gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
# Send e-mail straight from forms in Rails with I18n, validations, attachments and request information.
# Database based asynchronous priority queue system
gem 'delayed_job_active_record'
# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps
gem 'kaminari'
# Minimagick Gem
gem 'mini_magick'
#Toast Notification
gem 'toastr-rails'
# search gem
gem "scoped_search"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
	#Better error page for Rack apps
	gem 'better_errors'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  #deploy
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'

  # Add this if you're using rbenv
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
