require 'spec_helper'

describe StringDirection::Detector do
  context '#initialize(*strategies)' do
    it 'sets strategies arguments in the given order as strategies instance variable array' do
      detector = described_class.new(:marks, :characters)

      expect(detector.strategies).to eq([:marks, :characters])
    end

    context "if it can't infer the strategy class from given symbol" do
      it 'raises an ArgumentError' do
        expect { described_class.new(:something) }.to raise_error(ArgumentError)
      end
    end

    context 'if stragies are not given' do
      it 'takes defaults set in default_strategies configuration option' do
        detector = described_class.new

        expect(detector.strategies).to eq(StringDirection.configuration.default_strategies)
      end
    end
  end

  context '#direction(string)' do
    context 'when first strategy detects direction' do
      it 'returns it' do
        expect_any_instance_of(StringDirection::MarksStrategy).to receive(:analyze).and_return(StringDirection::LTR)

        detector = described_class.new(:marks, :characters)

        expect(detector.direction('abc')).to eq(StringDirection::LTR)
      end
    end

    context 'when first strategy does not detect direction' do
      it 'it tries with the second' do
        expect_any_instance_of(StringDirection::MarksStrategy).to receive(:analyze).and_return(nil)
        expect_any_instance_of(StringDirection::CharactersStrategy).to receive(:analyze).and_return(StringDirection::RTL)

        detector = described_class.new(:marks, :characters)

        expect(detector.direction('abc')).to eq(StringDirection::RTL)
      end
    end

    context 'when no strategy detects direction' do
      it 'returns nil' do
        expect_any_instance_of(StringDirection::MarksStrategy).to receive(:analyze).and_return(nil)
        expect_any_instance_of(StringDirection::CharactersStrategy).to receive(:analyze).and_return(nil)

        detector = described_class.new(:marks, :characters)

        expect(detector.direction('abc')).to be_nil
      end
    end
  end

  describe '#ltr?(string)' do
    let(:detector) { described_class.new(:marks, :characters) }

    context 'when string has ltr direction' do
      it 'returns true' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::LTR)

        expect(detector.ltr?('abc')).to eq(true)
      end
    end

    context 'when string has not ltr direction' do
      it 'returns false' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::RTL)

        expect(detector.ltr?('abc')).to eq(false)
      end
    end
  end

  describe '#rtl?(string)' do
    let(:detector) { described_class.new(:marks, :characters) }

    context 'when string has rtl direction' do
      it 'returns true' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::RTL)

        expect(detector.rtl?('abc')).to eq(true)
      end
    end

    context 'when string has not rtl direction' do
      it 'returns false' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::BIDI)

        expect(detector.rtl?('abc')).to eq(false)
      end
    end
  end

  describe '#bidi?(string)' do
    let(:detector) { described_class.new(:marks, :characters) }

    context 'when string has bidi direction' do
      it 'returns true' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::BIDI)

        expect(detector.bidi?('abc')).to eq(true)
      end
    end

    context 'when string has not bidi direction' do
      it 'returns false' do
        expect(detector).to receive(:direction).with('abc').and_return(StringDirection::LTR)

        expect(detector.bidi?('abc')).to eq(false)
      end
    end
  end
end
