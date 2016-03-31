require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Member do
  let(:identifier) { ActivityProvider::LRS::Identifier.new(mbox: 'test@email.com') }

  def valid_attributes
    { identifier: identifier, name: 'name' }
  end

  describe '#initialize' do
    it 'creates instance of Member without errors' do
      expect do
        described_class.new(valid_attributes)
      end.to_not raise_error
    end

    it { expect(described_class.new(valid_attributes).object_type).to eq('Agent') }
  end

  describe '#as_json' do
    let(:dumped_hash) do
      {
        name: valid_attributes[:name],
        objectType: 'Agent',
        mbox: identifier.mbox
      }
    end

    subject { described_class.new(valid_attributes).as_json }

    it { is_expected.to eq(dumped_hash) }
  end
end
