source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.5'

gem 'activeadmin', '~> 2.7'
gem 'arctic_admin', '~> 3.2'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form', '~> 4.0'
gem 'fast_jsonapi'
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'httparty', '~> 0.18'
gem 'jquery-rails'
gem 'jwt', '~> 2.2.1'
gem 'mechanize', '~> 2.7'
gem 'mini_magick'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0'
gem 'sass-rails', '~> 5'
gem 'skylight'
gem 'sidekiq', '~> 6.0.5'
gem 'sidekiq-batch'
gem 'sidekiq-scheduler', '~> 3.0.1'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'dotenv-rails'
  gem 'faker'
  gem 'letter_opener'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'capistrano-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
