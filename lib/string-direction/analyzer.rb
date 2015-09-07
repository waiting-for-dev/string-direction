module StringDirection
  # Abstract parent class for string direction analyzers
  class Analyzer
    attr_accessor :string

    def initialize(string)
      self.string = string
    end

    def analyze
      fail NotImplementedError, 'You must implement `analyze` method'
    end
  end
end
