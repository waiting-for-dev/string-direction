module StringDirection
  class Detector
    attr_accessor :strategies

    def initialize(*strategies)
      if strategies.empty?
        self.strategies = StringDirection.configuration.default_strategies
      else
        self.strategies = strategies
      end
      check_strategies
    end

    def direction(string)
      direction = nil
      strategies.each do |strategy|
        direction = strategy_class(strategy).new(string).run
        break if direction
      end
      direction
    end

    def ltr?(string)
      direction(string) == StringDirection::LTR
    end

    def rtl?(string)
      direction(string) == StringDirection::RTL
    end

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
