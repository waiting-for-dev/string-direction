module StringDirection
  class Configuration
    attr_accessor :rtl_scripts, :default_strategies

    def initialize
      self.rtl_scripts = %w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh)
      self.default_strategies = [:marks, :characters]
    end
  end
end
