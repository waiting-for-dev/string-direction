module StringDirection
  class Configuration
    attr_accessor :rtl_scripts, :default_analyzers

    def initialize
      self.rtl_scripts = %w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh)
      self.default_analyzers = [:marks, :characters]
    end
  end
end
