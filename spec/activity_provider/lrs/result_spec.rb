require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Result do
  let(:valid_attributes) do
    { success: true }
  end

  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }

    it { is_expected.to eq(success: valid_attributes[:success]) }
  end
end
