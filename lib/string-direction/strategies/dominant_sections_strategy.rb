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
      counts = Hash.new(0)
      each_section do |type, length|
        counts[type] += length
      end
      return nil if counts[ltr] == counts[rtl]
      counts.max_by { |_k, v| v }.first
    end

    # yields once for each ltr / rtl "section" in the string, with the type
    # being ltr or rtl and length being the length of the section
    def each_section
      # find the start of the first section - the first ltr / rtl character
      starts = { ltr => next_ltr_character(0), rtl => next_rtl_character(0) }
      type, start = starts.reject { |_k, v| v.nil? }.min_by { |_k, v| v }
      # neither rtl / ltr were found
      return if start.nil?
      loop do
        # if the current section is ltr then it finishes at the next rtl character
        finish = type == ltr ? next_rtl_character(start) : next_ltr_character(start)
        break if finish.nil?
        yield type, finish - start
        type = type == ltr ? rtl : ltr
        start = finish
      end
      yield type, @s.length - start
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
