module StringDirection
  class Configuration
    attr_accessor :rtl_scripts

    def initialize
      self.rtl_scripts = %w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh)
    end

    def reset
      StringDirection.configuration = self.class.new
    end
  end
end
