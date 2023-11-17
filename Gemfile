source "https://rubygems.org"

ruby "3.2.1"

gem "rails", "~> 7.1.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jbuilder"
# gem "redis", ">= 4.0.1"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'fabrication'
end

group :test do
  gem 'shoulda-matchers'
  gem 'rspec-json_expectations'
end
