require 'spec_helper'

RSpec.describe ActivityProvider::Configuration do
  describe '#intialize' do
    it 'sets default statement_path' do
      configuration = ActivityProvider::Configuration.new
      expect(configuration.statement_path).to eq('/statements')
    end
  end
end
