source 'https://rubygems.org'
ruby '2.3.3'

gem 'rails', '4.2.5'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-normalize-css'
  gem 'rails-assets-datetimepicker'
  gem 'rails-assets-d3'
  gem 'rails-assets-labella'
  gem 'rails-assets-tether'
  gem 'rails-assets-drop'
  gem 'rails-assets-tether-tooltip'
end

gem 'jbuilder', '~> 2.0'
gem 'mongoid', '~> 5.0.0'

gem 'sinatra', :require => nil
gem 'sidekiq', '~> 4.0.0'
gem 'sidekiq-cron'

gem 'slim'
gem 'formtastic'

group :development, :test do
  gem 'byebug'
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'letter_opener'
end

group :production do
  gem 'puma'
end
