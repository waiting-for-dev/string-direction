require 'spec_helper'

describe StringDirection::Strategy do
  it { expect(subject).to respond_to(:run).with(1).argument }
end
