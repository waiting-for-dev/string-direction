module StringDirection
  # Strategy to decide direction between ltr or rtl in function of which is the main type
  class DominantSectionsStrategy < CharactersStrategy
    # Get the number of ltr and rtl characters in the supplied string and infer
    # direction from the most common type. For this strategy the direction can
    # be ltr or rtl, but never bidi. In case of draw it returns nil.
    #
    # params [String] The string to inspect
    # @return [String, nil]
    def run(string)
      string = string.to_s
      ltr_characters = string.scan(ltr_regex).size
      rtl_characters = string.scan(rtl_regex).size
      diff = ltr_characters - rtl_characters
      return ltr if diff > 0
      return rtl if diff < 0
      nil
    end
  end
end
