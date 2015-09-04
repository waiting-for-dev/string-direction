# encoding: UTF-8

require 'spec_helper'

describe StringDirection do
  it 'has a version number' do
    expect(StringDirection::VERSION).not_to be nil
  end

  let(:english) { 'English' }
  let(:arabic) { 'العربية' }

  describe '::direction(string)' do
    context 'when unicode marks are present' do
      context 'when it contains the left-to-right mark but not the right-to-left mark' do
        it "returns 'ltr'" do
          string = described_class::LTR_MARK + english

          expect(described_class.direction(string)).to eql 'ltr'
        end
      end

      context 'when it contains the right-to-left mark but not the left-to-right mark' do
        it "returns 'rtl'" do
          string = described_class::RTL_MARK + arabic

          expect(described_class.direction(string)).to eql 'rtl'
        end
      end

      context 'when it contains both the left-to-right mark and the right-to-left mark' do
        it "returns 'bidi'" do
          string = described_class::LTR_MARK + english + described_class::RTL_MARK + arabic

          expect(described_class.direction(string)).to eql 'bidi'
        end
      end
    end

    context 'when unicode marks are not present' do
      context 'when no right-to-left character is present' do
        it "returns 'ltr'" do
          string = english

          expect(described_class.direction(string)).to eql 'ltr'
        end
      end

      context 'when only right-to-left character are present' do
        it "returns 'rtl'" do
          string = arabic

          expect(described_class.direction(string)).to eql 'rtl'
        end
      end

      context 'when both left-to-right and right-to-left characters are present' do
        it "returns 'bidi'" do
          string = arabic + ' ' + english

          expect(described_class.direction(string)).to eql 'bidi'
        end
      end

      context 'when default right-to-left scripts are changed' do
        let(:new_rtl_script) { 'Latin' }
        let(:old_rtl_script) { 'Arabic' }

        context 'when there are characters from an added right-to-left script' do
          it "treats them as right-to-left chracters" do
            StringDirection.rtl_scripts << new_rtl_script
            string = english

            expect(described_class.direction(string)).to eql 'rtl'
          end
        end

        context 'when there are characters from a deleted right-to-left script ' do
          it "treats them as left-to-right characters" do
            StringDirection.rtl_scripts.delete old_rtl_script
            string = arabic

            expect(described_class.direction(string)).to eql 'ltr'
          end
        end

        context 'when special characters are present' do
          it 'ignores them' do
            mark = "\u0903"
            punctuation = '_'
            symbol = '€'
            separator = ' '
            other = "\u0005"
            string = arabic + mark + punctuation + symbol + separator + other

            expect(described_class.direction(string)).to eql 'rtl'
          end
        end

        after :each do
          StringDirection.rtl_scripts.delete new_rtl_script if StringDirection.rtl_scripts.include? new_rtl_script
          StringDirection.rtl_scripts << old_rtl_script unless StringDirection.rtl_scripts.include? old_rtl_script
        end
      end
    end
  end

  describe '::is_ltr?' do
    context 'when it is a left-to-right string' do
      it 'returns true ' do
        string = english

        expect(described_class.is_ltr?(string)).to eq(true)
      end
    end

    context 'when it is not a left-to-right string' do
      it 'returns false' do
        string = arabic

        expect(described_class.is_ltr?(string)).to eq(false)
      end
    end
  end

  describe '::is_rtl?' do
    context 'when it is a right-to-left string' do
      it 'returns true' do
        string = arabic

        expect(described_class.is_rtl?(string)).to eq(true)
      end
    end

    context 'when it is not a right-to-left string' do
      it 'returns false' do
        string = english

        expect(described_class.is_rtl?(string)).to eq(false)
      end
    end
  end

  describe '::is_bidi?' do
    context 'when it is a bi-directional string' do
      it 'returns true' do
        string = english + ' ' + arabic

        expect(described_class.is_bidi?(string)).to eq(true)
      end
    end

    context 'when it is not a bi-directional string' do
      it 'returns false' do
        string = english

        expect(described_class.is_bidi?(string)).to eq(false)
      end
    end
  end
end
