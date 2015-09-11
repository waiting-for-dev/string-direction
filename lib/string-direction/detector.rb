module StringDirection
  # String direction detector
  class Detector
    # Array of strategies used, in order, to try to detect the direction of a string
    #
    # @return [Array]
    attr_accessor :strategies

    # Initialize strategies from given arguments. If no strategies are given, they are taken from the value of {StringDirection::Configuration#default_strategies}
    #
    # @raise [ArgumentError] if strategy class is not found. For example, for an strategy `:marks` a class `StringDirection::MarksStrategy` is expected
    def initialize(*strategies)
      if strategies.empty?
        self.strategies = StringDirection.configuration.default_strategies
      else
        self.strategies = strategies
      end
      check_strategies
    end

    # Tries to detect and return the direction of a string. It returns `ltr` if the string is left-to-right, `rtl` if it is right-to-left, `bidi` if it is bidirectional or `nil` if it can't detect the direction. It iterates through {#strategies} until one of them successes.
    #
    # @param string [String] The string to inspect
    # @return [String]
    def direction(string)
      direction = nil
      strategies.each do |strategy|
        direction = strategy_class(strategy).new(string).run
        break if direction
      end
      direction
    end

    # Returns whether string is left-to-right or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def ltr?(string)
      direction(string) == StringDirection::LTR
    end

    # Returns whether string is right-to-left or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def rtl?(string)
      direction(string) == StringDirection::RTL
    end

    # Returns whether string is bidirectional or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def bidi?(string)
      direction(string) == StringDirection::BIDI
    end

    private

    def check_strategies
      strategies.each do |strategy|
        begin
          strategy_class(strategy)
        rescue NameError
          raise ArgumentError, "Can't find '#{strategy}' strategy"
        end
      end
    end

    def strategy_class(strategy)
      name = "StringDirection::#{strategy.to_s.capitalize}Strategy"
      Kernel.const_get(name)
    end
  end
end
