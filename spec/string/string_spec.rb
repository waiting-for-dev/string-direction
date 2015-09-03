#encoding: UTF-8
require 'spec_helper'

describe String do
  let(:english) { 'English' }
  let(:arabic) { 'العربية' }
  describe "#direction" do
    context "when marks are present" do
      it "returns 'ltr' if it contains the left-to-right mark and no right-to-left mark" do
        string = String::LTR_MARK+english
        expect(string.direction).to eql 'ltr'
      end
      it "returns 'rtl' if it contains the right-to-left mark and no left-to-right mark" do
        string = String::RTL_MARK+arabic
        expect(string.direction).to eql 'rtl'
      end
      it "returns 'bidi' if it contains both the left-to-right mark and the right-to-left mark" do
        string = String::LTR_MARK+english+String::RTL_MARK+arabic
        expect(string.direction).to eql 'bidi'
      end
    end
    context "when marks are not present" do
      it "returns 'ltr' if no right-to-left character is present" do
        string = english
        expect(string.direction).to eql 'ltr'
      end
      it "returns 'rtl' if only right-to-left character are present" do
        string = arabic
        expect(string.direction).to eql 'rtl'
      end
      it "returns 'bidi' if both left-to-right and right-to-left characters are present" do
        string = arabic+' '+english
        expect(string.direction).to eql 'bidi'
      end
    end
    context "when default rtl scripts are changed" do
      let(:new_rtl_script) { 'Latin' }
      let(:old_rtl_script) { 'Arabic' }
      it "returns 'rtl' if there are characters for an added right-to-left script and no marks characters are present" do
        StringDirection.rtl_scripts << new_rtl_script
        string = english
        expect(string.direction).to eql 'rtl'
      end
      it "returns 'ltr' if there are characters for a deleted right-to-left script (so now ltr) and no mark characters are present" do
        StringDirection.rtl_scripts.delete old_rtl_script
        string = arabic
        expect(string.direction).to eql 'ltr'
      end
      after :each do
        StringDirection.rtl_scripts.delete new_rtl_script if StringDirection.rtl_scripts.include? new_rtl_script
        StringDirection.rtl_scripts << old_rtl_script unless StringDirection.rtl_scripts.include? old_rtl_script
      end
      context "when special characters are present" do
        it "ignores special characters for the direction detection" do
          mark = "\u0903"
          punctuation = "_"
          symbol = "€"
          separator = " "
          other = "\u0005"
          string = arabic+mark+punctuation+symbol+separator+other
          expect(string.direction).to eql 'rtl'
        end
      end
    end
  end
  describe "#is_ltr?" do
    it "returns true if it is a left-to-right string" do
      string = english
      expect(string.is_ltr?).to eq(true)
    end
    it "returns false if it is not a left-to-right string" do
      string = arabic
      expect(string.is_ltr?).to eq(false)
    end
  end
  describe "#is_rtl?" do
    it "returns true if it is a right-to-left string" do
      string = arabic
      expect(string.is_rtl?).to eq(true)
    end
    it "returns false if it is not a right-to-left string" do
      string = english
      expect(string.is_rtl?).to eq(false)
    end
  end
  describe "#is_bidi?" do
    it "returns true if it is a bi-directional string" do
      string = english+' '+arabic
      expect(string.is_bidi?).to eq(true)
    end
    it "returns false if it is not a bi-directional string" do
      string = english
      expect(string.is_bidi?).to eq(false)
    end
  end
end
