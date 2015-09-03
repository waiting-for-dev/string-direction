#encoding: UTF-8

# Module with all the logic for automatic detection of text direction. It will be included in String class.
module StringDirection
  LTR_MARK = "\u200e".freeze # left-to-right unicode mark
  RTL_MARK = "\u200f".freeze # right-to-left unicode mark

  # Regular expressions used to match direction markers
  LTR_MARK_REGEX    = /#{LTR_MARK}/.freeze # String contains a LTR marker
  RTL_MARK_REGEX    = /#{RTL_MARK}/.freeze # String contains a RTL marker
  CHAR_IGNORE_REGEX = /[\p{M}\p{P}\p{S}\p{Z}\p{C}]/.freeze # ignore unicode marks, punctuations, symbols, separator and other general categories

  # direction strings that get passed around
  BIDI = 'bidi'.freeze
  RTL  = 'rtl'.freeze
  LTR  = 'ltr'.freeze

  # returns the direction in which a string is written
  #
  # @return ["ltr"] if it's a left-to-right string
  # @return ["rtl"] if it's a right-to-left string
  # @return ["bidi"] if it's a bi-directinal string
  def direction
    if has_ltr_mark? && has_rtl_mark?
      BIDI
    elsif has_ltr_mark?
      LTR
    elsif has_rtl_mark?
      RTL
    elsif !has_rtl_characters?
      LTR
    elsif has_ltr_characters?
      BIDI
    else
      RTL
    end
  end

  # whether string is a left-to-right one
  #
  # @return [Boolean] true if it is a left-to-right string, false otherwise
  def is_ltr?
    direction === LTR
  end

  # whether string is a right-to-left one
  #
  # @return [Boolean] true if it is a right-to-left string, false otherwise
  def is_rtl?
    direction === RTL
  end

  # whether string is a bi-directional one
  #
  # @return [Boolean] true if it is a bi-directional string, false otherwise
  def is_bidi?
    direction === BIDI
  end

  # returns whether string contains the unicode left-to-right mark
  #
  # @return [Boolean] true if it containts ltr mark, false otherwise
  def has_ltr_mark?
    !!match(LTR_MARK_REGEX)
  end

  # returns whether string contains the unicode right-to-left mark
  #
  # @return [Boolean] true if it containts rtl mark, false otherwise
  def has_rtl_mark?
    !!match(RTL_MARK_REGEX)
  end

  # returns whether string contains some right-to-left character
  #
  # @return [Boolean] true if it containts rtl characters, false otherwise
  def has_rtl_characters?
    !!match(/[#{StringDirection::join_scripts_for_regexp(StringDirection.rtl_scripts)}]/)
  end

  # returns whether string contains some left-to-right character
  #
  # @return [Boolean] true if it containts ltr characters, false otherwise
  def has_ltr_characters?
    # ignore unicode marks, punctuations, symbols, separator and other general categories
    !!gsub(CHAR_IGNORE_REGEX, '').match(/[^#{StringDirection::join_scripts_for_regexp(StringDirection.rtl_scripts)}]/)
  end

  class << self
    attr_accessor :rtl_scripts

    # hook that is called when the module is included and that initializes rtl_scripts
    #
    # @param [Module] base The base module from within current module is included
    def included(base)
      @rtl_scripts = %w[Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh]
    end

    # given an array of script names, which should be supported by Ruby {http://www.ruby-doc.org/core-1.9.3/Regexp.html#label-Character+Properties regular expression properties}, returns a string where all of them are concatenaded inside a "\\p{}" construction
    #
    # @param [Array] scripts the array of script names
    # @return [String] the script names joined ready to be used in the construction of a regular expression
    # @example
    #   StringDirection.join_scripts_for_regexp(%w[Arabic Hebrew]) #=> "\p{Arabic}\p{Hebrew}"
    def join_scripts_for_regexp(scripts)
      scripts.map { |script| '\p{'+script+'}' }.join
    end
  end
end
