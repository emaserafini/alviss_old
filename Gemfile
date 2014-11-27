source 'https://rubygems.org'

ruby '2.1.5'

# BASIC
gem 'rails', '4.2.0.beta4'
gem 'pg'
gem 'spring', groups: [:development, :test]
gem 'spring-commands-rspec', group: :development

# ASSETS
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails', '~> 4.0.0.beta2'

gem 'sass-rails', '~> 5.0.0.beta1'
gem 'coffee-rails', '~> 4.1.0'

# HEROKU
gem 'rails_12factor', group: :production
gem 'passenger'

# MONITORING
gem 'skylight', group: :production

# DEBUG
group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0.0.beta4'
end

# TEST
group :test do
  gem 'rspec-rails', '~> 3.1.0', group: :development
end
