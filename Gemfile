source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.6.3"

gem "active_storage_validations", "0.8.2"
gem "ancestry"
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.2", require: false
gem "bootstrap-sass", "3.4.1"
gem "cancancan"
gem "config"
gem "devise"
gem "faker", "2.1.2"
gem "figaro"
gem "font-awesome-rails"
gem "i18n-js"
gem "image_processing", "1.9.3"
gem "jbuilder", "~> 2.7"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick", "4.9.5"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 4.3"
gem "rails", "~> 6.0.1"
gem "rails-i18n"
gem "ransack"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 0.74.0", require: false
  gem "rubocop-rails", "~> 2.3.2", require: false
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "database_cleaner", "~> 1.5"
  gem "factory_bot_rails"
  gem "rails-controller-testing"
  %w(rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support)
    .each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: "master"
  end
  gem "selenium-webdriver"
  gem "shoulda-matchers", "~> 3.0", require: false
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
