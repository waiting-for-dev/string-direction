# frozen_string_literal: true

module StringDirection
  # Strategy to detect direction from the scripts to which string characters belong
  class CharactersStrategy < Strategy
    # Ignored characters: unicode marks, punctuations, symbols, separator and other general categories
    IGNORED_CHARS = '\p{M}\p{P}\p{S}\p{Z}\p{C}'

    # Inspect to wich scripts characters belongs and  infer from them the string direction.
    # right-to-left scripts are those in {Configuration#rtl_scripts}.
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

    def rtl_regex
      @rtl_regex ||= /[#{rtl_script_character_classes}]/
    end

    def ltr_regex
      @ltr_regex ||= /[^#{rtl_script_character_classes}#{IGNORED_CHARS}]/
    end

    def rtl_characters?(string)
      string.match(rtl_regex)
    end

    def ltr_characters?(string)
      string.match(ltr_regex)
    end

    def rtl_script_character_classes
      @rtl_script_character_classes ||= rtl_scripts.map { |script| "\\p{#{script}}" }.join
    end

    def rtl_scripts
      StringDirection.configuration.rtl_scripts
    end
  end
end
