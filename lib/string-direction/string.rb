class String
  # returns the direction in which self is written
  #
  # @return ["left"] if it's a left-to-right string
  def direction
    'left' if self.match /^(.*)\u200e(.*)$/
  end
end
