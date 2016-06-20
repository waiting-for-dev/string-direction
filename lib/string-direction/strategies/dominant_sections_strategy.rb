module StringDirection
  # Strategy to detect direction from the scripts to which string characters
  # belong
  class DominantSectionsStrategy < CharactersStrategy
    # Get the length of ltr and rtl sections in the supplied string and
    # infer the direction from which type of section is the most common.
    # An rtl section starts with an rtl character and ends with an ltr character
    # An ltr section starts with an ltr character and ends with an rtl character
    #
    # params [String] The string to inspect
    # @return [String, nil]
    def run(string)
      @s = string.to_s

      first_rtl = next_rtl_character(0)
      first_ltr = next_ltr_character(0)
      return nil if first_rtl.nil? && first_ltr.nil?
      return rtl if first_ltr.nil?
      return ltr if first_rtl.nil?

      if first_ltr < first_rtl
        current = ltr
        ltr_characters = first_rtl - first_ltr
        rtl_characters = 0
        i = first_rtl
      else
        current = rtl
        ltr_characters = 0
        rtl_characters = first_ltr - first_rtl
        i = first_ltr
      end

      while i < @s.length
        previous = i
        if current == rtl
          i = next_ltr_character(previous) || @s.length
          rtl_characters += i - previous
          current = ltr
        else
          i = next_rtl_character(previous) || @s.length
          ltr_characters += i - previous
          current = rtl
        end
      end
      return ltr if ltr_characters > rtl_characters
      return rtl if rtl_characters > ltr_characters
      nil
    end

    private

    def next_ltr_character(i)
      @s.match(ltr_regex, i) { |m| m.begin(0) }
    end

    def next_rtl_character(i)
      @s.match(rtl_regex, i) { |m| m.begin(0) }
    end
  end
end
