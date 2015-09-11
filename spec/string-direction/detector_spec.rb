require 'spec_helper'

describe StringDirection::Detector do
  module StringDirection::Strategies
    class LtrStrategy
      def run(string)
        StringDirection::LTR
      end
    end

    class RtlStrategy
      def run(string)
        StringDirection::RTL
      end
    end

    class BidiStrategy
      def run(string)
        StringDirection::BIDI
      end
    end

    class NilStrategy
      def run(string)
        nil
      end
    end
  end

  context '#initialize(*strategies)' do
    it 'sets initialized strategies inflected from arguments in the given order as strategies instance variable array' do
      detector = described_class.new(:ltr, :nil)

      expect(detector.strategies.first).to be_an_instance_of(StringDirection::Strategies::LtrStrategy)
      expect(detector.strategies.last).to be_an_instance_of(StringDirection::Strategies::NilStrategy)
    end

    context "if it can't infer the strategy class from given symbol" do
      it 'raises an ArgumentError' do
        expect { described_class.new(:something) }.to raise_error(ArgumentError)
      end
    end

    context 'if stragies are not given' do
      it 'takes defaults set in default_strategies configuration option' do
        allow(StringDirection.configuration).to receive(:default_strategies).and_return([:ltr])

        detector = described_class.new

        expect(detector.strategies.first).to be_an_instance_of(StringDirection::Strategies::LtrStrategy)
      end
    end
  end

  context '#direction(string)' do
    context 'when first strategy detects direction' do
      it 'returns it' do
        detector = described_class.new(:ltr, :rtl)

        expect(detector.direction('abc')).to eq(StringDirection::LTR)
      end
    end

    context 'when first strategy does not detect direction' do
      it 'it tries with the second' do
        detector = described_class.new(:nil, :rtl)

        expect(detector.direction('abc')).to eq(StringDirection::RTL)
      end
    end

    context 'when no strategy detects direction' do
      it 'returns nil' do
        detector = described_class.new(:nil)

        expect(detector.direction('abc')).to be_nil
      end
    end
  end

  describe '#ltr?(string)' do
    context 'when string has ltr direction' do
      it 'returns true' do
        detector = described_class.new(:ltr)

        expect(detector.ltr?('abc')).to eq(true)
      end
    end

    context 'when string has not ltr direction' do
      it 'returns false' do
        detector = described_class.new(:rtl)

        expect(detector.ltr?('abc')).to eq(false)
      end
    end
  end

  describe '#rtl?(string)' do
    context 'when string has rtl direction' do
      it 'returns true' do
        detector = described_class.new(:rtl)

        expect(detector.rtl?('abc')).to eq(true)
      end
    end

    context 'when string has not rtl direction' do
      it 'returns false' do
        detector = described_class.new(:bidi)

        expect(detector.rtl?('abc')).to eq(false)
      end
    end
  end

  describe '#bidi?(string)' do
    context 'when string has bidi direction' do
      it 'returns true' do
        detector = described_class.new(:bidi)

        expect(detector.bidi?('abc')).to eq(true)
      end
    end

    context 'when string has not bidi direction' do
      it 'returns false' do
        detector = described_class.new(:ltr)

        expect(detector.bidi?('abc')).to eq(false)
      end
    end
  end
end
