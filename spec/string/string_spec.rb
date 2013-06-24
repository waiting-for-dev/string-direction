require 'spec_helper'

describe String do
  describe "#direction" do
    it "should return 'left' if it contains the left-to-right mark and no right-to-left mark" do
      string = "\u200eHola"
      string.direction.should eql 'left'
    end
  end
end
