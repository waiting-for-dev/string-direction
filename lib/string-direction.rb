require 'string-direction/version'
require 'string-direction/configuration'
require 'string-direction/detector'
require 'string-direction/strategies'
require 'string-direction/string_methods'

# Constants & configuration common in the whole library
module StringDirection
  # left-to-right identifier
  LTR  = 'ltr'.freeze

  # right-to-left identifier
  RTL  = 'rtl'.freeze

  # bidi identifier
  BIDI = 'bidi'.freeze

  class << self
    # {Configuration} object
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    # Yields current {Configuration}
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    # Reset {Configuration}
    def reset_configuration
      self.configuration = Configuration.new
    end
  end
end
