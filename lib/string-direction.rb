# encoding: UTF-8

require 'string-direction/version'
require 'string-direction/configuration'
require 'string-direction/analyzer'

# Module with all the logic for automatic detection of text direction
module StringDirection
  LTR_MARK = "\u200e".freeze # left-to-right unicode mark
  RTL_MARK = "\u200f".freeze # right-to-left unicode mark

  # Regular expressions used to match direction markers
  LTR_MARK_REGEX    = /#{LTR_MARK}/.freeze # String contains a LTR marker
  RTL_MARK_REGEX    = /#{RTL_MARK}/.freeze # String contains a RTL marker
  CHAR_IGNORE_REGEX = /[\p{M}\p{P}\p{S}\p{Z}\p{C}]/.freeze # Ignore unicode marks, punctuations, symbols, separator and other general categories

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

    # given an array of script names, which should be supported by Ruby {http://www.ruby-doc.org/core-1.9.3/Regexp.html#label-Character+Properties regular expression properties}, returns a string where all of them are concatenaded inside a "\\p{}" construction
    #
    # @param [Array] scripts the array of script names
    # @return [String] the script names joined ready to be used in the construction of a regular expression
    # @example
    #   StringDirection.join_scripts_for_regexp(%w(Arabic Hebrew)) #=> "\p{Arabic}\p{Hebrew}"
    def join_scripts_for_regexp(scripts)
      scripts.map { |script| '\p{'+script+'}' }.join
    end

    # returns the direction in which a string is written
    #
    # @return ["ltr"] if it's a left-to-right string
    # @return ["rtl"] if it's a right-to-left string
    # @return ["bidi"] if it's a bi-directinal string
    def direction(string)
      string = string.to_s
      if has_ltr_mark?(string) && has_rtl_mark?(string)
        BIDI
      elsif has_ltr_mark?(string)
        LTR
      elsif has_rtl_mark?(string)
        RTL
      elsif !has_rtl_characters?(string)
        LTR
      elsif has_ltr_characters?(string)
        BIDI
      else
        RTL
      end
    end

    # whether string is a left-to-right one
    #
    # @return [Boolean] true if it is a left-to-right string, false otherwise
    def is_ltr?(string)
      direction(string) == LTR
    end

    # whether string is a right-to-left one
    #
    # @return [Boolean] true if it is a right-to-left string, false otherwise
    def is_rtl?(string)
      direction(string) == RTL
    end

    # whether string is a bi-directional one
    #
    # @return [Boolean] true if it is a bi-directional string, false otherwise
    def is_bidi?(string)
      direction(string) == BIDI
    end

    # returns whether string contains the unicode left-to-right mark
    #
    # @return [Boolean] true if it containts ltr mark, false otherwise
    def has_ltr_mark?(string)
      string.match(LTR_MARK_REGEX) ? true : false
    end

    # returns whether string contains the unicode right-to-left mark
    #
    # @return [Boolean] true if it containts rtl mark, false otherwise
    def has_rtl_mark?(string)
      string.match(RTL_MARK_REGEX) ? true : false
    end

    # returns whether string contains some right-to-left character
    #
    # @return [Boolean] true if it containts rtl characters, false otherwise
    def has_rtl_characters?(string)
      string.match(/[#{StringDirection::join_scripts_for_regexp(StringDirection.configuration.rtl_scripts)}]/) ? true : false
    end

    # returns whether string contains some left-to-right character
    #
    # @return [Boolean] true if it containts ltr characters, false otherwise
    def has_ltr_characters?(string)
      # ignore unicode marks, punctuations, symbols, separator and other general categories
      string.gsub(CHAR_IGNORE_REGEX, '').match(/[^#{StringDirection::join_scripts_for_regexp(StringDirection.configuration.rtl_scripts)}]/) ? true : false
    end
  end
end
