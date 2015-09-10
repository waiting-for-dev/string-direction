shared_examples_for 'strategy' do
  it { expect(described_class.new('abc')).to respond_to(:analyze) }

  describe '#initialize(string)' do
    it 'sets string argument as string instance variable' do
      strategy = described_class.new('abc')

      expect(strategy.string).to eq('abc')
    end

    context 'when an object responding to #to_s is given' do
      it 'sets the result of calling #to_s as string instance variable' do
        class StringDirection::ToStringTestObject
          def to_s
            'abc'
          end
        end

        strategy = described_class.new(StringDirection::ToStringTestObject.new)

        expect(strategy.string).to eq('abc')
      end
    end
  end
end
