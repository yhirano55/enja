require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH << File.expand_path("../support", __FILE__)

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)
ENV["RAILS_ENV"] ||= "test"

# Ensure the Active Admin load path is happy
require "rails"
require "enja"

ENV["RAILS"] = Rails.version
ENV["RAILS_ROOT"] = File.expand_path("../rails/rails-#{ENV['RAILS']}", __FILE__)

# Create the test app if it doesn't exists
unless File.exist?(ENV["RAILS_ROOT"])
  system "rails new spec/rails/rails-#{Rails::VERSION::STRING} -m spec/support/rails_template.rb -T -B --skip-spring --skip-sprockets"
end

# load test app
require ENV["RAILS_ROOT"] + "/config/environment.rb"

require "rspec/rails"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end

  config.order = :random

  config.use_transactional_fixtures = true
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
