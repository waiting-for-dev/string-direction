# frozen_string_literal: true

require 'spec_helper'

describe StringDirection::DominantStrategy do
  describe '#run' do
    let(:english) { 'English' }
    let(:arabic) { 'العربية' }

    subject { described_class.new.run(string) }

    context 'when both left-to-right and right-to-left characters are present in equal numbers' do
      let(:string) { arabic + english }

      it 'returns nil' do
        expect(subject).to eq nil
      end
    end

    context 'when both left-to-right and right-to-left characters are present, with more ltr' do
      let(:string) { english + arabic + english }

      it "returns 'ltr'" do
        expect(subject).to eq 'ltr'
      end
    end

    context 'when right-to-left character are present but none of left-to-right' do
      let(:string) { arabic }

      it "returns 'rtl'" do
        expect(subject).to eq 'rtl'
      end
    end

    context 'when left-to-right character are present but none of right-to-left' do
      let(:string) { english }

      it "returns 'ltr'" do
        expect(subject).to eq 'ltr'
      end
    end

    context 'when neither left-to-right nor right-to-left characters are present' do
      let(:string) { ' ' }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end

    context 'when default right-to-left scripts are changed' do
      let(:new_rtl_script) { 'Latin' }
      let(:old_rtl_script) { 'Arabic' }

      context 'when there are characters from an added right-to-left script' do
        let(:string) { english }

        it 'treats them as right-to-left chracters' do
          StringDirection.configure do |config|
            config.rtl_scripts << new_rtl_script
          end

          expect(subject).to eq 'rtl'
        end
      end

      context 'when there are characters from a deleted right-to-left script ' do
        let(:string) { arabic }

        it 'treats them as left-to-right characters' do
          StringDirection.configure do |config|
            config.rtl_scripts.delete(old_rtl_script)
          end

          expect(subject).to eq 'ltr'
        end
      end

      after :each do
        StringDirection.reset_configuration
      end
    end

    context 'when special characters are present' do
      let(:string) do
        mark = "\u0903"
        punctuation = '_'
        symbol = '€'
        separator = ' '
        other = "\u0005"

        arabic + mark + punctuation + symbol + separator + other
      end

      it 'ignores them' do
        expect(subject).to eq 'rtl'
      end
    end

    context 'when an object responding to #to_s is given' do
      let(:string) do
        class StringDirection::TestObject
          def to_s
            'English'
          end
        end

        StringDirection::TestObject.new
      end

      it 'takes as string the result of #to_s method' do
        expect(subject).to eq('ltr')
      end
    end
  end
end
