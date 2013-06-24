class String
  # left-to-right unicode mark
  LTR_MARK = "\u200e"

  # right-to-left unicode mark
  RTL_MARK = "\u200f"

  # right-to-left characters unicode blocks
  RTL_UNICODE_BLOCKS = [
    # Hebrew main letters
    "\u0590-\u05ff",
    # Arabic main letters
    "\u0600-\u06ff",
    # Syriac main letters
    "\u0700-\u074f",
    # Arabic supplement
    "\u0750-\u077f",
    # Thaana main letters
    "\u0780-\u07bf",
    # N'Ko main letters
    "\u07c0-\u07ff",
    # Samaritan main letters
    "\u0800-\u083f",
    # Arabic extended
    "\u08a0-\u08ff",
    # Hebrew presentation form
    "\ufb1d-\ufb4f",
    # Arabic presentation form 1
    "\ufb50-\ufdff",
    # Arabic presentation form 2
    "\ufe70-\ufeff",
  ]

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
    match(Regexp.union(*RTL_UNICODE_BLOCKS)) ? true : false
  end
end
