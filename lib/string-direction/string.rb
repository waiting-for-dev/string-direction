#encoding: UTF-8

class String
  # left-to-right unicode mark
  LTR_MARK = "\u200e"

  # right-to-left unicode mark
  RTL_MARK = "\u200f"

  # returns the direction in which self is written
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
    elsif has_rtl_characters?
      'right'
    end
  end

  # returns whether self contains the unicode left-to-right mark
  #
  # @return [Boolean] true if it containts ltr mark, false otherwise
  def has_ltr_mark?
    match(/^(.*)#{LTR_MARK}(.*)$/) ? true : false
  end

  # returns whether self contains the unicode right-to-left mark
  #
  # @return [Boolean] true if it containts rtl mark, false otherwise
  def has_rtl_mark?
    match(/^(.*)#{RTL_MARK}(.*)$/) ? true : false
  end

  # returns whether self contains some right-to-left character
  #
  # @return [Boolean] true if it containts rtl characters, false otherwise
  def has_rtl_characters?
    match(/\p{Arabic}|\p{Hebrew}|\p{Nko}|\p{Syriac}|\p{Thaana}|\p{Tifinagh}/) ? true : false
  end
end
