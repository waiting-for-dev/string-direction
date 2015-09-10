require 'spec_helper'

describe StringDirection::Configuration do
  describe '#rtl_scripts' do
    it 'defaults to an array with Arabic, Hebrew, Nko, Kharoshthi, Phoenician, Syriac, Thaana and Tifinagh' do
      expect(subject.rtl_scripts).to match_array(%w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh))
    end
  end

  describe '#default_analyzers' do
    it 'defaults to an array with :marks and :characters' do
      expect(subject.default_analyzers).to eq([:marks, :characters])
    end
  end
end
