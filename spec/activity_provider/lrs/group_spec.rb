require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Group do
  let(:identifier) { ActivityProvider::LRS::Identifier.new(mbox: 'test@email.com') }
  let(:valid_attributes) do
    { identifier: identifier, name: 'name' }
  end

  describe '#initialize' do
    it 'creates instance of Group without errors' do
      expect do
        described_class.new(valid_attributes)
      end.to_not raise_error
    end

    it { expect(described_class.new(valid_attributes).object_type).to eq('Group') }
  end

  describe '#as_json' do
    subject { described_class.new(attrs).as_json }

    context 'without members' do
      let(:attrs) { valid_attributes }
      let(:dumped_hash) do
        {
          name: valid_attributes[:name],
          objectType: 'Group',
          mbox: identifier.mbox
        }
      end

      it { is_expected.to eq(dumped_hash) }
    end

    context 'with members' do
      let(:member) { ActivityProvider::LRS::Member.new(identifier: identifier) }
      let(:attrs) do
        valid_attributes.merge(members: [member])
      end
      let(:dumped_hash) do
        {
          name: valid_attributes[:name],
          objectType: 'Group',
          mbox: identifier.mbox,
          member: [member]
        }
      end

      it { is_expected.to eq(dumped_hash) }
    end
  end
end
