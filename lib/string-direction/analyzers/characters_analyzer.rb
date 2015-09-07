module StringDirection
  class CharactersAnalyzer < Analyzer
    # Regular expressions used to match direction markers
    CHAR_IGNORE_REGEX = /[\p{M}\p{P}\p{S}\p{Z}\p{C}]/.freeze # Ignore unicode marks, punctuations, symbols, separator and other general categories

    def analyze
      if !has_rtl_characters?(string)
        StringDirection::LTR
      elsif has_ltr_characters?(string)
        StringDirection::BIDI
      else
        StringDirection::RTL
      end
    end

    private

    # returns whether string contains some right-to-left character
    #
    # @return [Boolean] true if it containts rtl characters, false otherwise
    def has_rtl_characters?(string)
      string.match(/[#{StringDirection::join_scripts_for_regexp(StringDirection.configuration.rtl_scripts)}]/) ? true : false
    end

    # returns whether string contains some left-to-right character
    #
    # @return [Boolean] true if it containts ltr characters, false otherwise
    def has_ltr_characters?(string)
      # ignore unicode marks, punctuations, symbols, separator and other general categories
      string.gsub(CHAR_IGNORE_REGEX, '').match(/[^#{join_scripts_for_regexp(StringDirection.configuration.rtl_scripts)}]/) ? true : false
    end

    # given an array of script names, which should be supported by Ruby {http://www.ruby-doc.org/core-1.9.3/Regexp.html#label-Character+Properties regular expression properties}, returns a string where all of them are concatenaded inside a "\\p{}" construction
    #
    # @param [Array] scripts the array of script names
    # @return [String] the script names joined ready to be used in the construction of a regular expression
    # @example
    #   StringDirection.join_scripts_for_regexp(%w(Arabic Hebrew)) #=> "\p{Arabic}\p{Hebrew}"
    def join_scripts_for_regexp(scripts)
      scripts.map { |script| '\p{'+script+'}' }.join
    end
  end
end
