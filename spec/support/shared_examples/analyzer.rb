shared_examples_for 'strategy' do
  it { expect(described_class.new).to respond_to(:run).with(1).argument }
end
