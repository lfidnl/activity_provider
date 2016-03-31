require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Account do
  def valid_attributes
    { home_page: 'http://homepage', name: 'name' }
  end

  describe '#initialize' do
    it 'creates instance of Account without errors' do
      expect do
        described_class.new(valid_attributes)
      end.to_not raise_error
    end
  end

  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }

    it { is_expected.to eq(homePage: valid_attributes[:home_page], name: valid_attributes[:name]) }
  end
end
