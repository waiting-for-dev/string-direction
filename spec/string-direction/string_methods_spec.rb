require 'spec_helper'

describe StringDirection::StringMethods do
  subject { 'abc' }

  before :each do
    String.include(StringDirection::StringMethods)
  end

  describe '#direction' do
    it 'returns string direction' do
      expect(subject.direction).to eq(StringDirection::LTR)
    end
  end

  describe '#ltr?' do
    it 'returns whether string direction is ltr' do
      expect(subject.ltr?).to eq(true)
    end
  end

  describe '#rtl?' do
    it 'returns whether string direction is rtl' do
      expect(subject.rtl?).to eq(false)
    end
  end

  describe '#bidi?' do
    it 'returns whether string direction is bidi' do
      expect(subject.bidi?).to eq(false)
    end
  end
end
