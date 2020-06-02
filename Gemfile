source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "rails", "~> 6.0.0"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "super", github: "zachahn/super"
gem "super_test_engine", "~> 0.1.1"

group :development, :test do
  gem "pry-byebug"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end
