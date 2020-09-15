# frozen_string_literal: true

module StringDirection
  # Strategy to decide direction between ltr or rtl in function of which is the main type
  class DominantStrategy < CharactersStrategy
    # Get the number of ltr and rtl characters in the supplied string and infer
    # direction from the most common type. For this strategy the direction can
    # be ltr or rtl, but never bidi. In case of draw it returns nil.
    #
    # params [String] The string to inspect
    # @return [String, nil]
    def run(string)
      string = string.to_s
      ltr_count = chars_count(string, ltr_regex)
      rtl_count = chars_count(string, rtl_regex)
      diff = ltr_count - rtl_count
      return ltr if diff > 0
      return rtl if diff < 0

      nil
    end

    private

    def chars_count(string, regex)
      count = 0
      string.scan(regex) { count += 1 }
      count
    end
  end
end
