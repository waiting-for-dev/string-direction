# frozen_string_literal: true

require 'spec_helper'

describe StringDirection do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '::LTR' do
    it "is 'ltr'" do
      expect(described_class::LTR).to eq('ltr')
    end
  end

  describe '::RTL' do
    it "is 'rtl'" do
      expect(described_class::RTL).to eq('rtl')
    end
  end

  describe '::BIDI' do
    it "is 'bidi'" do
      expect(described_class::BIDI).to eq('bidi')
    end
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

  describe '#reset_configuration' do
    it 'sets its configuration instance var as a new instance of Configuration' do
      StringDirection.configure {}
      configuration = StringDirection.configuration

      StringDirection.reset_configuration

      expect(StringDirection.configuration).to be_an_instance_of(StringDirection::Configuration)
      expect(StringDirection.configuration).not_to eq(configuration)
    end
  end
end
