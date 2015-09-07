require 'spec_helper'

describe StringDirection::Analyzer do
  it { expect(described_class.new('abc')).to respond_to(:analyze) }

  describe '#initialize(string)' do
    it 'sets string argument as string instance variable' do
      analyzer = described_class.new('abc')

      expect(analyzer.string).to eq('abc')
    end
  end
end
