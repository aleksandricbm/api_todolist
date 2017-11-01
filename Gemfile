source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

gem 'devise_token_auth'
gem 'pg'
gem 'omniauth-facebook', '~> 4.0.0'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'pry-byebug', '~> 3.4.2'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'guard-rspec'
  gem 'spring-commands-rspec'
  gem 'vcr'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.14.4'
  gem 'capybara-webkit', '= 1.1.0'
  gem 'database_cleaner', '~> 1.6.1'
  gem 'rails-controller-testing', '~> 1.0.2'
  gem 'shoulda-matchers', '~> 3.1.2'
end
