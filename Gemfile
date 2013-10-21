source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'sass'
gem 'haml'
gem 'mongoid', '~>3.0.0'

# Test requirements
group :test do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
  gem 'database_cleaner'
  gem 'factory_girl'
end

# Padrino Stable Gem
gem 'padrino', '0.11.4'

# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.11.4'
# end

gem 'ms_lorem', :require => false
