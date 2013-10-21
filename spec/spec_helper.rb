PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'database_cleaner'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  # Clean test db
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end

  FactoryGirl.definition_file_paths = [
    File.join(Padrino.root, 'spec', 'factories')
  ]
  FactoryGirl.find_definitions
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Banners::App
#   app Banners::App.tap { |a| }
#   app(Banners::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end
