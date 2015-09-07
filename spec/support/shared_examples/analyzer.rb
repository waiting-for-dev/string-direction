shared_examples_for 'analyzer' do
  it { expect(described_class.new('abc')).to respond_to(:analyze) }

  describe '#initialize(string)' do
    it 'sets string argument as string instance variable' do
      analyzer = described_class.new('abc')

      expect(analyzer.string).to eq('abc')
    end

    context 'when an object responding to #to_s is given' do
      it 'sets the result of calling #to_s as string instance variable' do
        class StringDirection::ToStringTestObject
          def to_s
            'abc'
          end
        end

        analyzer = described_class.new(StringDirection::ToStringTestObject.new)

        expect(analyzer.string).to eq('abc')
      end
    end
  end
end
