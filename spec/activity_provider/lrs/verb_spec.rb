require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Verb do
  let(:valid_attributes) do
    { verb: 'answered' }
  end

  describe '#as_json' do
    subject { described_class.new(attrs).as_json }
    let(:attrs) { valid_attributes }

    it do
      dumped_hash = { id: 'http://www.adlnet.gov/expapi/verbs/answered',
                      display: { :"en-US" => 'answered' } }
      is_expected.to eq(dumped_hash)
    end
  end
end
