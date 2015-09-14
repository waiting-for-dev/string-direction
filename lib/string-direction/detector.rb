module StringDirection
  # String direction detector
  class Detector
    # Array of initialized strategies used, in order, to try to detect the direction of a string
    #
    # @return [Array]
    attr_accessor :strategies

    # Initialize strategies from given arguments. If no strategies are given, they are taken from the value of {StringDirection::Configuration#default_strategies}
    #
    # @raise [ArgumentError] if strategy class is not found. For example, for an strategy `:marks` a class `StringDirection::MarksStrategy` is expected
    def initialize(*strategies)
      strategies = StringDirection.configuration.default_strategies if strategies.empty?
      initialize_strategies(strategies)
    end

    # Tries to detect and return the direction of a string. It returns `ltr` if the string is left-to-right, `rtl` if it is right-to-left, `bidi` if it is bidirectional or `nil` if it can't detect the direction. It iterates through {#strategies} until one of them successes.
    #
    # @param string [String] The string to inspect
    # @return [String, nil]
    def direction(string)
      direction = nil
      strategies.each do |strategy|
        direction = strategy.run(string)
        break if direction
      end
      direction
    end

    # Returns whether string is left-to-right or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def ltr?(string)
      direction(string) == ltr
    end

    # Returns whether string is right-to-left or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def rtl?(string)
      direction(string) == rtl
    end

    # Returns whether string is bidirectional or not
    #
    # @param string [String] The string to inspect
    # @return [Boolean]
    def bidi?(string)
      direction(string) == bidi
    end

    private

    def initialize_strategies(strategies)
      self.strategies = strategies.map do |strategy|
        begin
          name = infer_strategy_class_name(strategy)
          Kernel.const_get(name).new
        rescue NameError
          raise ArgumentError, "Can't find '#{name}' strategy"
        end
      end
    end

    def infer_strategy_class_name(strategy)
      base_name = strategy.to_s.split('_').map(&:capitalize).join
      "StringDirection::#{base_name}Strategy"
    end

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
