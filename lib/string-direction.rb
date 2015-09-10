# encoding: UTF-8

require 'string-direction/version'
require 'string-direction/configuration'
require 'string-direction/analyzer'
require 'string-direction/detector'
require 'string-direction/string_methods'

# Module with all the logic for automatic detection of text direction
module StringDirection
  # Direction strings that get passed around
  BIDI = 'bidi'.freeze
  RTL  = 'rtl'.freeze
  LTR  = 'ltr'.freeze

  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def reset_configuration
      self.configuration = Configuration.new
    end
  end
end
