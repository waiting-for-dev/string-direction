module StringDirection
  module StringMethods
    def direction
      detector.direction(self)
    end

    def ltr?
      detector.ltr?(self)
    end

    def rtl?
      detector.rtl?(self)
    end

    def bidi?
      detector.bidi?(self)
    end

    private

    def detector
      @detector ||= StringDirection::Detector.new
    end
  end
end
