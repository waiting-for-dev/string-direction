#encoding: UTF-8

# Module with all the logic for automatic detection of text direction. It will be included in String class.
module StringDirection
  # left-to-right unicode mark
  LTR_MARK = "\u200e"

  # right-to-left unicode mark
  RTL_MARK = "\u200f"

  # right-to-left scripts
  RTL_SCRIPTS = %w[Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh]

  def self.included(base)
  end

  # returns the direction in which a string is written
  #
  # @return ["left"] if it's a left-to-right string
  # @return ["right"] if it's a right-to-left string
  # @return ["bidi"] if it's a bi-directinal string
  def direction
    if has_ltr_mark? and has_rtl_mark?
      'bidi'
    elsif has_ltr_mark?
      'left'
    elsif has_rtl_mark?
      'right'
    elsif not has_rtl_characters?
      'left'
    elsif has_ltr_characters?
      'bidi'
    else
      'right'
    end
  end

  # whether string is a left-to-right one
  #
  # @return [Boolean] true if it is a left-to-right string, false otherwise
  def is_ltr?
    (direction == 'left') ? true : false
  end

  # whether string is a right-to-left one
  #
  # @return [Boolean] true if it is a right-to-left string, false otherwise
  def is_rtl?
    (direction == 'right') ? true : false
  end

  # whether string is a bi-directional one
  #
  # @return [Boolean] true if it is a bi-directional string, false otherwise
  def is_bidi?
    (direction == 'bidi') ? true : false
  end

  # returns whether string contains the unicode left-to-right mark
  #
  # @return [Boolean] true if it containts ltr mark, false otherwise
  def has_ltr_mark?
    match(/^(.*)#{LTR_MARK}(.*)$/) ? true : false
  end

  # returns whether string contains the unicode right-to-left mark
  #
  # @return [Boolean] true if it containts rtl mark, false otherwise
  def has_rtl_mark?
    match(/^(.*)#{RTL_MARK}(.*)$/) ? true : false
  end

  # returns whether string contains some right-to-left character
  #
  # @return [Boolean] true if it containts rtl characters, false otherwise
  def has_rtl_characters?
    match(/[#{StringDirection::join_scripts_for_regexp(RTL_SCRIPTS)}]/) ? true : false
  end

  # returns whether string contains some left-to-right character
  #
  # @return [Boolean] true if it containts ltr characters, false otherwise
  def has_ltr_characters?
    match(/[^#{StringDirection::join_scripts_for_regexp(RTL_SCRIPTS)}]/) ? true : false
  end

  # given an array of scripts, which should be supported by Ruby {http://www.ruby-doc.org/core-1.9.3/Regexp.html#label-Character+Properties regular expression properties}, returns a string where all of them are concatenaded inside a "\\p{}" construction
  #
  # @param [Array] scripts the array of scripts
  # @return [String] the script names joined ready to be used in the construction of a regular expression
  # @example
  #   StringDirection.join_scripts_for_regexp(%w[Arabic Hebrew]) #=> "\p{Arabic}\p{Hebrew}"
  def self.join_scripts_for_regexp(scripts)
    scripts.map { |script| '\p{'+script+'}' }.join
  end
end
