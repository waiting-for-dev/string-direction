#encoding: UTF-8
require 'spec_helper'

ENGLISH = 'English'
ARABIC = 'العربية'
LTR_MARK = "\u200e"
RTL_MARK = "\u200f"

describe String do
  describe "#direction" do
    context "when marks are present" do
      it "should return 'left' if it contains the left-to-right mark and no right-to-left mark" do
        string = LTR_MARK+ENGLISH
        string.direction.should eql 'left'
      end
      it "should return 'right' if it contains the right-to-left mark and no left-to-right mark" do
        string = RTL_MARK+ARABIC
        string.direction.should eql 'right'
      end
      it "should return 'bidi' if it contains both the left-to-right mark and the right-to-left mark" do
        string = LTR_MARK+ENGLISH+RTL_MARK+ARABIC
        string.direction.should eql 'bidi'
      end
    end
    context "when marks are not present" do
      it "should return 'left' if no right-to-left character is present" do
        string = ENGLISH
        string.direction.should eql 'left'
      end
      it "should return 'right' if only right-to-left character are present" do
        string = ARABIC
        string.direction.should eql 'right'
      end
      it "should return 'bidi' if both left-to-right and right-to-left characters are present" do
        string = ARABIC+' '+ENGLISH
        string.direction.should eql 'bidi'
      end
    end
  end
  describe "#is_ltr?" do
    it "should return true if it is a left-to-right string" do
      string = ENGLISH
      string.is_ltr?.should be_true
    end
    it "should return false if it is not a left-to-right string" do
      string = ARABIC
      string.is_ltr?.should be_false
    end
  end
  describe "#is_rtl?" do
    it "should return true if it is a right-to-left string" do
      string = ARABIC
      string.is_rtl?.should be_true
    end
    it "should return false if it is not a right-to-left string" do
      string = ENGLISH
      string.is_rtl?.should be_false
    end
  end
  describe "#is_bidi?" do
    it "should return true if it is a bi-directional string" do
      string = ENGLISH+' '+ARABIC
      string.is_bidi?.should be_true
    end
    it "should return false if it is not a bi-directional string" do
      string = ENGLISH
      string.is_bidi?.should be_false
    end
  end
end
