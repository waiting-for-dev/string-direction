# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'string-direction'
require 'pry'

Dir[File.join(__dir__, 'support/**/*.rb')].sort.each { |f| require f }
RSpec.configure do |config|
  config.color = true
end
