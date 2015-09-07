module StringDirection
  class Detector
    attr_accessor :analyzers

    def initialize(*analyzers)
      self.analyzers = analyzers
    end
  end
end
