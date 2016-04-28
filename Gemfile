source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1'


gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '>= 3.2' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'font-awesome-sass' # Use font awesome for some sweet fonts & icons

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap'
gem 'devise'
gem 'mail_form'
gem 'ckeditor'
gem 'actionview-encoded_mail_to'
gem 'has_scope', '~> 0.6.0' # to help with model searches
gem 'select2-rails' # to help with dropdown searches

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '1.3.8'
  gem 'faker'
  gem 'better_errors'
end

group :test do

  gem 'ruby-prof'
  gem "minitest-rails"

  # guard testing
  gem 'guard'
  gem 'guard-minitest' # https://github.com/guard/guard-minitest
  gem 'minitest-colorize'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
  gem 'newrelic_rpm'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
