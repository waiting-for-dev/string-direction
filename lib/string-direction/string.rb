class String
  LTR_MARK = "\u200e"
  RTL_MARK = "\u200f"

  # returns the direction in which self is written
  #
  # @return ["left"] if it's a left-to-right string
  # @return ["right"] if it's a right-to-left string
  # @return ["bidi"] if it's a bi-directinal string
  def direction
    if self.has_ltr_mark? and self.has_rtl_mark?
      'bidi'
    elsif self.has_ltr_mark?
      'left'
    elsif self.has_rtl_mark?
      'right'
    end
  end

  def has_ltr_mark?
    self.match(/^(.*)#{LTR_MARK}(.*)$/) ? true : false
  end

  def has_rtl_mark?
    self.match(/^(.*)#{RTL_MARK}(.*)$/) ? true : false
  end
end
