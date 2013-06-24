class String
  LTR_MARK = "\u200e"
  RTL_MARK = "\u200f"

  # returns the direction in which self is written
  #
  # @return ["left"] if it's a left-to-right string
  def direction
    if self.has_ltr_mark?
      'left'
    elsif self.has_rtl_mark?
      'right'
    end
  end

  def has_ltr_mark?
    self.match(/^(.*)#{LTR_MARK}(.*)$/) ? true : false
  end

  def has_rtl_mark?
    self.match(/^(.*)#{LTR_MARK}(.*)$/) ? false : true
  end
end
