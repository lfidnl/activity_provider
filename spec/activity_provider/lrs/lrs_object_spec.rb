require 'spec_helper'

RSpec.describe ActivityProvider::LRS::LRSObject do
  let(:valid_attributes) do
    { id: 'http://some/id' }
  end
  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }
    it { is_expected.to eq(objectType: 'Activity', id: valid_attributes[:id]) }
  end
end
