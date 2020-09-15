# frozen_string_literal: true

module StringDirection
  # Strategy to detect direction looking for the presence of unicode marks
  class MarksStrategy < Strategy
    # left-to-right unicode mark
    LTR_MARK = "\u200e"

    # right-to-right unicode mark
    RTL_MARK = "\u200f"

    # Look for the presence of unicode marks in given string and infers from them its direction
    #
    # params [String] The string to inspect
    # @return [String, nil]
    def run(string)
      string = string.to_s
      if ltr_mark?(string) && rtl_mark?(string)
        bidi
      elsif ltr_mark?(string)
        ltr
      elsif rtl_mark?(string)
        rtl
      end
    end

    private

    def ltr_mark?(string)
      string.include?(LTR_MARK)
    end

    def rtl_mark?(string)
      string.include?(RTL_MARK)
    end
  end
end
