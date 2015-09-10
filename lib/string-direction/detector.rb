module StringDirection
  class Detector
    attr_accessor :analyzers

    def initialize(*analyzers)
      self.analyzers = analyzers
      check_analyzers
    end

    def direction(string)
      direction = nil
      analyzers.each do |analyzer|
        direction = analyzer_class(analyzer).new(string).analyze
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

    def check_analyzers
      analyzers.each do |analyzer|
        begin
          analyzer_class(analyzer)
        rescue NameError
          raise ArgumentError, "Can't find '#{analyzer}' analyzer"
        end
      end
    end

    def analyzer_class(analyzer)
      name = "StringDirection::#{analyzer.to_s.capitalize}Analyzer"
      Kernel.const_get(name)
    end
  end
end
