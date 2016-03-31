require 'spec_helper'
require 'fakeweb'

RSpec.describe ActivityProvider::LRS::Client do
  let(:xapi_url) { 'http://some/xapi/url' }

  before do
    FakeWeb.allow_net_connect = false
    ActivityProvider.configure do |config|
      config.xapi_url = xapi_url
      config.statement_path = '/statement/path'
    end
    described_class.base_uri ActivityProvider.config.xapi_url
  end

  describe '#send_statements' do
    before do
      FakeWeb.register_uri(:post, xapi_url + ActivityProvider.config.statement_path, status: 200, body: '["id"]')
    end

    it 'sends POST request to LRS' do
      statements = [double(:statement, to_json: '')]
      described_class.new.send_statements(statements)
      expect(FakeWeb.last_request).to be_a(Net::HTTP::Post)
    end
  end

  describe '#save_statement' do
    before do
      FakeWeb.register_uri(:put, xapi_url + ActivityProvider.config.statement_path, status: 204, body: '')
    end

    it 'sends PUT request to LRS' do
      statement = double(:statement, to_json: '')
      described_class.new.save_statement(statement)
      expect(FakeWeb.last_request).to be_a(Net::HTTP::Put)
    end
  end

  describe '#fetch_statement' do
    let(:statement_id) { 'id' }

    subject { described_class.new.fetch_statement(statement_id) }

    before do
      FakeWeb.register_uri(:get, xapi_url + ActivityProvider.config.statement_path + "?statementId=#{statement_id}",
                           status: 200, body: '{}')
    end

    it 'sends GET request to LRS' do
      subject
      expect(FakeWeb.last_request).to be_a(Net::HTTP::Get)
    end

    it { is_expected.to be_a(ActivityProvider::LRS::Statement) }
  end
end
