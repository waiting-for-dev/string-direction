require 'spec_helper'

describe StringDirection::MarksStrategy do
  describe '#run' do
    subject { described_class.new.run(string) }

    context 'when string contains the left-to-right mark but not the right-to-left mark' do
      let(:string) { described_class::LTR_MARK + 'abc' }

      it "returns 'ltr'" do
        expect(subject).to eql 'ltr'
      end
    end

    context 'when string contains the right-to-left mark but not the left-to-right mark' do
      let(:string) { described_class::RTL_MARK + 'abc' }

      it "returns 'rtl'" do
        expect(subject).to eql 'rtl'
      end
    end

    context 'when string contains both the left-to-right mark and the right-to-left mark' do
      let(:string) { described_class::LTR_MARK + described_class::RTL_MARK + 'abc' }

      it "returns 'bidi'" do
        expect(subject).to eql 'bidi'
      end
    end

    context 'when string neither contains the left-to-right mark nor the right-to-left mark' do
      let(:string) { 'abc' }

      it "returns nil" do
        expect(subject).to be_nil
      end
    end

    context 'when an object responding to #to_s is given' do
      let(:string) do
        class StringDirection::TestObject
          def to_s
            StringDirection::MarksStrategy::LTR_MARK
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
