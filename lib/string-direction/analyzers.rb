module StringDirection
  # Abstract parent class for string direction analyzers
  class Analyzer
    def analyze
      fail NotImplementedError, 'You must implement `direction` method'
    end
  end
end
