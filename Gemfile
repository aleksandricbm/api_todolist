source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'apipie-rails', '0.5.5'
gem 'rails', '~> 5.1.4'
gem 'rack-cors', require: 'rack/cors'
gem 'puma', '~> 3.7'
gem 'carrierwave-base64'
gem 'carrierwave-google-storage', '~> 0.7.0'
gem 'fog', '~> 1.42.0'
gem 'google-cloud', '~> 0.22.0'
gem 'dotenv-rails', '~> 2.2.1'
gem 'devise_token_auth', '~> 0.1.42'
gem 'pg', '~> 0.21.0'
gem 'cancancan', '~> 2.0'
gem 'foreman', '0.63.0'
gem 'acts_as_list', '0.9.9'

group :development, :test do
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'pry-byebug', '~> 3.4.2'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'guard-rspec', '~> 4.7.3'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'ffaker', '2.7.0'
end

group :development do
  gem 'rubocop', '~> 0.49.1'
  gem 'rails_best_practices', '~> 1.18.1'
  gem 'reek', '~> 4.7.1'
  gem 'overcommit', '~> 0.40.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'brakeman', '~> 3.7.0'
  gem 'fasterer', '~> 0.3.2'
  gem 'spring', '~> 2.0.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.14.4'
  gem 'capybara-webkit', '= 1.1.0'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'simplecov', '0.15.1', require: false
  gem 'json_matchers', '0.7.2'
  gem 'rubocop-rspec', '1.16.0'
end
