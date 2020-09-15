# frozen_string_literal: true

require 'spec_helper'

describe StringDirection::StringMethods do
  subject { 'abc'.dup }

  context 'in any case' do
    before :each do
      String.include StringDirection::StringMethods
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

  context 'when StringDirection.configuration.string_methods_strategies is changed' do
    before :each do
      class StringDirection::AlwaysRtlStrategy < StringDirection::Strategy
        def run(_string)
          rtl
        end
      end

      StringDirection.configure do |config|
        config.string_methods_strategies = [:always_rtl]
      end

      String.include StringDirection::StringMethods
    end

    it 'uses that configured strategies' do
      expect('abc'.dup.direction).to eq('rtl')
    end

    after :each do
      StringDirection.reset_configuration
    end
  end
end
