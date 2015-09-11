module StringDirection
  # Methods intended to be monkey patched to String through `String.include(StringDirection::StringMethods)`. This will allow stuff like `'English'.direction #=> 'ltr'`. All methods are delegated to {Detector} with `self` as string argument.
  module StringMethods
    # @see Detector#direction
    # @return [String]
    def direction
      string_direction_detector.direction(self)
    end

    # @see Detector#ltr?
    def ltr?
      string_direction_detector.ltr?(self)
    end

    # @see Detector#rtl?
    def rtl?
      string_direction_detector.rtl?(self)
    end

    # @see Detector#bidi?
    def bidi?
      string_direction_detector.bidi?(self)
    end

    private

    def string_direction_detector
      @string_direction_detector ||= StringDirection::Detector.new
    end
  end
end
