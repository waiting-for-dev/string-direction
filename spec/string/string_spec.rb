#encoding: UTF-8
require 'spec_helper'

describe String do
  let(:english) { 'English' }
  let(:arabic) { 'العربية' }
  describe "#direction" do
    context "when marks are present" do
      it "should return 'ltr' if it contains the left-to-right mark and no right-to-left mark" do
        string = String::LTR_MARK+english
        string.direction.should eql 'ltr'
      end
      it "should return 'rtl' if it contains the right-to-left mark and no left-to-right mark" do
        string = String::RTL_MARK+arabic
        string.direction.should eql 'rtl'
      end
      it "should return 'bidi' if it contains both the left-to-right mark and the right-to-left mark" do
        string = String::LTR_MARK+english+String::RTL_MARK+arabic
        string.direction.should eql 'bidi'
      end
    end
    context "when marks are not present" do
      it "should return 'ltr' if no right-to-left character is present" do
        string = english
        string.direction.should eql 'ltr'
      end
      it "should return 'rtl' if only right-to-left character are present" do
        string = arabic
        string.direction.should eql 'rtl'
      end
      it "should return 'bidi' if both left-to-right and right-to-left characters are present" do
        string = arabic+' '+english
        string.direction.should eql 'bidi'
      end
    end
    context "when default rtl scripts are changed" do
      let(:new_rtl_script) { 'Latin' }
      let(:old_rtl_script) { 'Arabic' }
      it "should return 'rtl' if there are characters for an added right-to-left script and no marks characters are present" do
        StringDirection.rtl_scripts << new_rtl_script
        string = english
        string.direction.should eql 'rtl'
      end
      it "should return 'ltr' if there are characters for a deleted right-to-left script (so now ltr) and no mark characters are present" do
        StringDirection.rtl_scripts.delete old_rtl_script
        string = arabic
        string.direction.should eql 'ltr'
      end
      after :each do
        StringDirection.rtl_scripts.delete new_rtl_script if StringDirection.rtl_scripts.include? new_rtl_script
        StringDirection.rtl_scripts << old_rtl_script unless StringDirection.rtl_scripts.include? old_rtl_script
      end
      context "when special characters are present" do
        it "should ignore special characters for the direction detection" do
          mark = "\u0903"
          punctuation = "_"
          symbol = "€"
          separator = " "
          other = "\u0005"
          string = arabic+mark+punctuation+symbol+separator+other
          string.direction.should eql 'rtl'
        end
      end
    end
  end
  describe "#is_ltr?" do
    it "should return true if it is a left-to-right string" do
      string = english
      string.is_ltr?.should eq(true)
    end
    it "should return false if it is not a left-to-right string" do
      string = arabic
      string.is_ltr?.should eq(false)
    end
  end
  describe "#is_rtl?" do
    it "should return true if it is a right-to-left string" do
      string = arabic
      string.is_rtl?.should eq(true)
    end
    it "should return false if it is not a right-to-left string" do
      string = english
      string.is_rtl?.should eq(false)
    end
  end
  describe "#is_bidi?" do
    it "should return true if it is a bi-directional string" do
      string = english+' '+arabic
      string.is_bidi?.should eq(true)
    end
    it "should return false if it is not a bi-directional string" do
      string = english
      string.is_bidi?.should eq(false)
    end
  end
end
