require 'spec_helper'

describe StringDirection::Configuration do
  describe '#rtl_scripts' do
    it 'returns by default an array with Arabic, Hebrew, Nko, Kharoshthi, Phoenician, Syriac, Thaana and Tifinagh' do
      expect(subject.rtl_scripts).to match_array(%w(Arabic Hebrew Nko Kharoshthi Phoenician Syriac Thaana Tifinagh))
    end
  end

  describe '#rtl_scripts=' do
    it 'assigns to rtl_scripts instance variable' do
      subject.rtl_scripts = %w(Arabic)

      expect(subject.rtl_scripts).to eq(%w(Arabic))
    end
  end

  describe '#reset' do
    it 'sets StringDirection configuration instance var as a new instance of Configuration' do
      StringDirection.configure {}
      configuration = StringDirection.configuration

      StringDirection.configuration.reset

      expect(StringDirection.configuration).to be_an_instance_of(described_class)
      expect(StringDirection.configuration).not_to eq(configuration)
    end
  end
end
