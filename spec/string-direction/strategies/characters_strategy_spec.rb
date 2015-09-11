require 'spec_helper'

describe StringDirection::Strategies::CharactersStrategy do
  it_behaves_like 'strategy'

  describe '#run' do
    let(:english) { 'English' }
    let(:arabic) { 'العربية' }

    subject { described_class.new.run(string) }

    context 'when no right-to-left character is present' do
      let(:string) { english }

      it "returns 'ltr'" do
        expect(subject).to eql 'ltr'
      end
    end

    context 'when only right-to-left character are present' do
      let(:string) { arabic }

      it "returns 'rtl'" do
        expect(subject).to eql 'rtl'
      end
    end

    context 'when both left-to-right and right-to-left characters are present' do
      let(:string) { arabic + english }

      it "returns 'bidi'" do
        expect(subject).to eql 'bidi'
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

          expect(subject).to eql 'rtl'
        end
      end

      context 'when there are characters from a deleted right-to-left script ' do
        let(:string) { arabic }

        it 'treats them as left-to-right characters' do
          StringDirection.configure do |config|
            config.rtl_scripts.delete(old_rtl_script)
          end

          expect(subject).to eql 'ltr'
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
          expect(subject).to eql 'rtl'
        end
      end

      after :each do
        StringDirection.reset_configuration
      end
    end
  end
end
