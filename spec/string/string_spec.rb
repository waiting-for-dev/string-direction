#encoding: UTF-8
require 'spec_helper'

describe String do
  describe "#direction" do
    it "should return 'left' if it contains the left-to-right mark and no right-to-left mark" do
      string = "\u200eHola"
      string.direction.should eql 'left'
    end

    it "should return 'right' if it contains the right-to-left mark and no left-to-right mark" do
      string = "\u200fالعربية"
      string.direction.should eql 'right'
    end
  end
end
