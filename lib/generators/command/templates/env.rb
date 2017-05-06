ENV['RAILS_ENV'] = 'test'
require "./config/environment"
require "rspec/rails"
require 'rack/test'
require 'database_cleaner'
require 'faker'

Dir[Rails.root.join('features/steps/common/**/*.rb')].each { |f| require f }

Spinach.hooks.before_scenario do
  DatabaseCleaner.clean
end

class Spinach::FeatureSteps
  include Rack::Test::Methods
  include Rails.application.routes.url_helpers
  include Common::Helper
  include RSpec::Matchers
end

ActiveRecord::Migration.maintain_test_schema!