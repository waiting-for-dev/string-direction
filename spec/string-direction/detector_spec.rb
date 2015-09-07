require 'spec_helper'

describe StringDirection::Detector do
  context '#initialize(*analyzers)' do
    it 'sets analyzer arguments in the given order as analyzers instance variable array' do
      detector = described_class.new('a', 'b')

      expect(detector.analyzers).to eq(%w(a b))
    end
  end
end
