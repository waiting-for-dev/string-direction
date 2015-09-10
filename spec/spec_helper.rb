$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'string-direction'
require 'pry'

Dir[File.join(__dir__, 'support/**/*.rb')].each { |f| require f }
RSpec.configure do |config|
  config.color = true
end
