require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Context do
  let(:context_activities) do
    ActivityProvider::LRS::ContextActivities.new({
      parent: [ActivityProvider::LRS::LRSObject.new(id: 'id')]
    })
  end

  def valid_attributes
    { context_activities: context_activities }
  end

  describe '#initialize' do
    it 'creates instance of Context without errors' do
      expect do
        described_class.new(valid_attributes)
      end.to_not raise_error
    end
  end

  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }

    it { is_expected.to eq(contextActivities: context_activities) }
  end
end
