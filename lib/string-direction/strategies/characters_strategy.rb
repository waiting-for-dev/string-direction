module StringDirection
  # Strategy to detect direction from the scripts to which string characters belong
  class CharactersStrategy < Strategy
    # Ignored characters: unicode marks, punctuations, symbols, separator and other general categories
    CHAR_IGNORE_REGEX = /[\p{M}\p{P}\p{S}\p{Z}\p{C}]/.freeze

    # Inspect to wich scripts characters belongs and  infer from them the string direction. right-to-left scripts are those in {Configuration#rtl_scripts}
    #
    # params [String] The string to inspect
    # @return [String, nil]
    def run(string)
      string = string.to_s
      if ltr_characters?(string) && rtl_characters?(string)
        bidi
      elsif ltr_characters?(string)
        ltr
      elsif rtl_characters?(string)
        rtl
      end
    end

    private

    def rtl_characters?(string)
      string.match(/[#{join_scripts_for_regexp(rtl_scripts)}]/) ? true : false
    end

    def ltr_characters?(string)
      string.gsub(CHAR_IGNORE_REGEX, '').match(/[^#{join_scripts_for_regexp(rtl_scripts)}]/) ? true : false
    end

    def join_scripts_for_regexp(scripts)
      scripts.map { |script| '\p{' + script + '}' }.join
    end

    def rtl_scripts
      StringDirection.configuration.rtl_scripts
    end
  end
end
