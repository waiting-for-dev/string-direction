# frozen_string_literal: true

module StringDirection
  # @abstract Subclass and override {#run} to implement
  class Strategy
    # Each strategy must implement this method, accepting an string as its argument. It must return
    # {StringDirection::LTR}, {StringDirection::RTL}, {StringDirection::BIDI} depending on direction
    # detected, or nil on detection failure.
    # @abstract
    # @raise [NotImplementedError]
    def run(_string)
      raise NotImplementedError, '`run` method must be implemented'
    end

    private

    def ltr
      StringDirection::LTR
    end

    def rtl
      StringDirection::RTL
    end

    def bidi
      StringDirection::BIDI
    end
  end
end
