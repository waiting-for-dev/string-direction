# frozen_string_literal: true

require 'spec_helper'

describe StringDirection::Configuration do
  describe '#rtl_scripts' do
    it 'defaults to an array with Arabic, Hebrew, Nko, Kharoshthi, Phoenician, Syriac, Thaana and Tifinagh' do
      expect(subject.rtl_scripts).to match_array(%w[Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh])
    end
  end

  describe '#default_strategies' do
    it 'defaults to an array with :marks and :characters' do
      expect(subject.default_strategies).to eq(%i[marks characters])
    end
  end

  describe '#string_methods_strategies' do
    it 'defaults to an array with :marks and :characters' do
      expect(subject.string_methods_strategies).to eq(%i[marks characters])
    end
  end
end
