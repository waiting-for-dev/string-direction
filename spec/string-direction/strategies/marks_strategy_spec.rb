require 'spec_helper'

describe StringDirection::MarksStrategy do
  it_behaves_like 'strategy'

  describe '#run' do
    let(:english) { 'English' }
    let(:arabic) { 'العربية' }

    subject { described_class.new(string).run }

    context 'when string contains the left-to-right mark but not the right-to-left mark' do
      let(:string) { described_class::LTR_MARK + arabic }

      it "returns 'ltr'" do
        expect(subject).to eql 'ltr'
      end
    end

    context 'when string contains the right-to-left mark but not the left-to-right mark' do
      let(:string) { described_class::RTL_MARK + english }

      it "returns 'rtl'" do
        expect(subject).to eql 'rtl'
      end
    end

    context 'when string contains both the left-to-right mark and the right-to-left mark' do
      let(:string) { described_class::LTR_MARK + described_class::RTL_MARK + english + arabic }

      it "returns 'bidi'" do
        expect(subject).to eql 'bidi'
      end
    end

    context 'when string neither contains the left-to-right mark nor the right-to-left mark' do
      let(:string) { arabic }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end
  end
end
