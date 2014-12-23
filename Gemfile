source 'https://rubygems.org'

ruby '2.1.5'

# BASIC
gem 'rails', '4.2.0'
gem 'pg'
gem 'spring', groups: [:development, :test]
gem 'spring-commands-rspec', group: :development
gem 'jbuilder', '~> 2.0'

# ASSETS
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'haml-rails'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'

# HEROKU
gem 'rails_12factor', group: :production
gem 'passenger'

# MONITORING
gem 'skylight', group: :production

# DEBUG
group :development, :test do
  gem 'pry'
  gem 'web-console', '~> 2.0'
end

# TEST
group :test do
  gem 'rspec-rails', '~> 3.1.0', group: :development
  gem 'factory_girl_rails'
end
