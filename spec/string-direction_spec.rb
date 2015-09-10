# encoding: UTF-8

require 'spec_helper'

describe StringDirection do
  it 'has a version number' do
    expect(StringDirection::VERSION).not_to be nil
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
