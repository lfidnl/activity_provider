require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Score do
  let(:valid_attributes) do
    { raw: 1, min: 1, max: 2, scaled: 0.12 }
  end

  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }

    let(:dumped_hash) do
      {
        raw: valid_attributes[:raw],
        min: valid_attributes[:min],
        max: valid_attributes[:max],
        scaled: valid_attributes[:scaled]
      }
    end

    it { is_expected.to eq(dumped_hash) }
  end
end
