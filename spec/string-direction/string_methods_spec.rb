require 'spec_helper'

describe StringDirection::StringMethods do
  subject { 'abc' }

  before :each do
    String.send(:include, StringDirection::StringMethods)
  end

  describe '#direction' do
    it 'returns string direction' do
      expect(subject.direction).to eq(StringDirection::LTR)
    end
  end

  describe '#ltr?' do
    it 'returns whether string direction is left-to-right' do
      expect(subject.ltr?).to eq(true)
    end
  end

  describe '#rtl?' do
    it 'returns whether string direction is right-to-left' do
      expect(subject.rtl?).to eq(false)
    end
  end

  describe '#bidi?' do
    it 'returns whether string direction is bidirectional' do
      expect(subject.bidi?).to eq(false)
    end
  end
end
