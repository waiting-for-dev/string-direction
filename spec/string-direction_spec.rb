# encoding: UTF-8

require 'spec_helper'

describe StringDirection do
  it 'has a version number' do
    expect(StringDirection::VERSION).not_to be nil
  end

  let(:english) { 'English' }
  let(:arabic) { 'العربية' }

  describe '::direction(string)' do
    let(:subject) { described_class.direction(string) }

    context 'when unicode marks are present' do
      context 'when it contains the left-to-right mark but not the right-to-left mark' do
        let(:string) { described_class::LTR_MARK + arabic }

        it "returns 'ltr'" do
          expect(subject).to eql 'ltr'
        end
      end

      context 'when it contains the right-to-left mark but not the left-to-right mark' do
        let(:string) { described_class::RTL_MARK + english }

        it "returns 'rtl'" do
          expect(subject).to eql 'rtl'
        end
      end

      context 'when it contains both the left-to-right mark and the right-to-left mark' do
        let(:string) { described_class::LTR_MARK + described_class::RTL_MARK + english + arabic }

        it "returns 'bidi'" do
          expect(subject).to eql 'bidi'
        end
      end
    end

    context 'when unicode marks are not present' do
      context 'when no right-to-left character is present' do
        let(:string) { english }

        it "returns 'ltr'" do
          expect(described_class.direction(string)).to eql 'ltr'
        end
      end

      context 'when only right-to-left character are present' do
        let(:string) { arabic }

        it "returns 'rtl'" do
          expect(described_class.direction(string)).to eql 'rtl'
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

          it "treats them as left-to-right characters" do
            StringDirection.configure do |config|
              config.rtl_scripts.delete(old_rtl_script)
            end

            expect(subject).to eql 'ltr'
          end
        end

        after :each do
          StringDirection.configure do |config|
            config.reset
          end
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
    end

    context 'when an object responding to #to_s is given as argument' do
      let(:string) do
        class described_class::TestObject
          def to_s
            'العربية'
          end
        end

        described_class::TestObject.new
      end

      it 'analyzes direction for whatever #to_s returns' do
        expect(subject).to eq('rtl')
      end
    end
  end

  describe '::is_ltr?' do
    let(:subject) { described_class.is_ltr?(string) }

    context 'when it is a left-to-right string' do
      let(:string) { english }

      it 'returns true ' do
        expect(subject).to eq(true)
      end
    end

    context 'when it is not a left-to-right string' do
      let(:string) { arabic }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end

  describe '::is_rtl?' do
    let(:subject) { described_class.is_rtl?(string) }

    context 'when it is a right-to-left string' do
      let(:string) { arabic }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when it is not a right-to-left string' do
      let(:string) { english }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end

  describe '::is_bidi?' do
    let(:subject) { described_class.is_bidi?(string) }

    context 'when it is a bi-directional string' do
      let(:string) { english + arabic }

      it 'returns true' do
        expect(subject).to eq(true)
      end
    end

    context 'when it is not a bi-directional string' do
      let(:string) { english }

      it 'returns false' do
        expect(subject).to eq(false)
      end
    end
  end

  describe '::configure' do
    it 'initializes configuration instance var with an instance of StringDirection::Configuration' do
      described_class.configure {}

      expect(described_class.configuration).to be_an_instance_of(StringDirection::Configuration)
    end

    it 'yields the Configuration instance' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(StringDirection.configuration)
    end
  end

  describe '::configuration' do
    context 'when configure block has not been called' do
      it 'returns a new instance of StringDirection::Configuration' do
        expect(described_class.configuration).to be_an_instance_of(StringDirection::Configuration)
      end
    end
  end
end
