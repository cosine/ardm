source 'https://rubygems.org'

gemspec

gem 'pry'
gem(RUBY_VERSION.sub(/\..*/, "") == "1" ? 'pry-debugger' : 'pry-byebug')

group :test do
  gem 'sqlite3'
  gem 'activerecord', '~> 3.2'
  gem 'addressable'
  gem 'database_cleaner'
end
