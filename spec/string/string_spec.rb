#encoding: UTF-8
require 'spec_helper'

describe String do
  let(:english) { 'English' }
  let(:arabic) { 'العربية' }
  describe "#direction" do
    context "when marks are present" do
      it "should return 'left' if it contains the left-to-right mark and no right-to-left mark" do
        string = String::LTR_MARK+english
        string.direction.should eql 'left'
      end
      it "should return 'right' if it contains the right-to-left mark and no left-to-right mark" do
        string = String::RTL_MARK+arabic
        string.direction.should eql 'right'
      end
      it "should return 'bidi' if it contains both the left-to-right mark and the right-to-left mark" do
        string = String::LTR_MARK+english+String::RTL_MARK+arabic
        string.direction.should eql 'bidi'
      end
    end
    context "when marks are not present" do
      it "should return 'left' if no right-to-left character is present" do
        string = english
        string.direction.should eql 'left'
      end
      it "should return 'right' if only right-to-left character are present" do
        string = arabic
        string.direction.should eql 'right'
      end
      it "should return 'bidi' if both left-to-right and right-to-left characters are present" do
        string = arabic+' '+english
        string.direction.should eql 'bidi'
      end
    end
    context "when default rtl scripts are changed" do
      let(:new_rtl_script) { 'Latin' }
      let(:old_rtl_script) { 'Arabic' }
      it "should return 'right' if there are characters for an added right-to-left script and no marks characters are present" do
        StringDirection.rtl_scripts << new_rtl_script
        string = english
        string.direction.should eql 'right'
      end
      it "should return 'left' if there are characters for a deleted right-to-left script (so now ltr) and no mark characters are present" do
        StringDirection.rtl_scripts.delete old_rtl_script
        string = arabic
        string.direction.should eql 'left'
      end
      after :each do
        StringDirection.rtl_scripts.delete new_rtl_script if StringDirection.rtl_scripts.include? new_rtl_script
        StringDirection.rtl_scripts << old_rtl_script unless StringDirection.rtl_scripts.include? old_rtl_script
      end
    end
  end
  describe "#is_ltr?" do
    it "should return true if it is a left-to-right string" do
      string = english
      string.is_ltr?.should be_true
    end
    it "should return false if it is not a left-to-right string" do
      string = arabic
      string.is_ltr?.should be_false
    end
  end
  describe "#is_rtl?" do
    it "should return true if it is a right-to-left string" do
      string = arabic
      string.is_rtl?.should be_true
    end
    it "should return false if it is not a right-to-left string" do
      string = english
      string.is_rtl?.should be_false
    end
  end
  describe "#is_bidi?" do
    it "should return true if it is a bi-directional string" do
      string = english+' '+arabic
      string.is_bidi?.should be_true
    end
    it "should return false if it is not a bi-directional string" do
      string = english
      string.is_bidi?.should be_false
    end
  end
end
