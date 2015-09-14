module StringDirection
  # {StringDirection} configuration
  class Configuration
    # Scripts for which characters are treated as right-to-left. Defaults to Arabic, Hebrew, Nko, Kharoshthi, Phoenician, Syriac, Thaana and Tifinagh. Notice than only {http://ruby-doc.org/core-2.2.3/Regexp.html#class-Regexp-label-Character+Properties recognized Ruby regular expression scripts} are accepted.
    #
    # @return [Array]
    attr_accessor :rtl_scripts

    # Default strategies, in order, that {Detector} uses if they are not given explicetly. Values are symbols with a matching class expected. For example, `:marks` expects a class `StringDirection::MarksStrategy` to exist. Defaults to `:marks` and `:characters`.
    #
    # @return [Array]
    attr_accessor :default_strategies

    # Strategies, in order, that {StringMethods} uses. Values are symbols with a matching class expected. For example, `:marks` expects a class `StringDirection::MarksStrategy` to exist. Defaults to `:marks` and `:characters`.
    #
    # @return [Array]
    attr_accessor :string_methods_strategies

    # Initialize defaults
    def initialize
      self.rtl_scripts = %w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh)
      self.default_strategies = [:marks, :characters]
      self.string_methods_strategies = [:marks, :characters]
    end
  end
end
