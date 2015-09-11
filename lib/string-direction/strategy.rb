module StringDirection
  # Abstract parent class for string direction strategies
  class Strategy
    attr_accessor :string

    def initialize(string)
      self.string = string.to_s
    end

    def run
      fail NotImplementedError, 'You must implement `run` method'
    end
  end
end
