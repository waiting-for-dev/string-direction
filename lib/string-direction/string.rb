class String
  LTR_MARK = "\u200e"
  RTL_MARK = "\u200f"

  # returns the direction in which self is written
  #
  # @return ["left"] if it's a left-to-right string
  def direction
    if self.match /^(.*)#{LTR_MARK}(.*)$/
      'left'
    elsif self.match /^(.*)#{RTL_MARK}(.*)$/
      'right'
    end
  end
end
