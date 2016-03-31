require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Identifier do
  describe '#initialize' do
    it 'creates instance of Identifier' do
      expect { described_class.new(mbox: 'test@email.com') }.to_not raise_error
    end
  end

  describe '#as_json' do
    subject { described_class.new(attrs).as_json }

    context 'with mbox' do
      let(:attrs) { { mbox: 'test@email.com' } }
      it { is_expected.to eq(mbox: attrs[:mbox]) }
    end

    context 'with mbox_sha1sum' do
      let(:attrs) { { mbox_sha1sum: 'sha1sum' } }
      it { is_expected.to eq(attrs) }
    end

    context 'with openid' do
      let(:attrs) { { openid: 'http://openid' } }
      it { is_expected.to eq(attrs) }
    end

    context 'with account' do
      let(:account) { ActivityProvider::LRS::Account.new(home_page: 'http://homepage', name: 'name') }
      let(:attrs) { { account: account } }
      it { is_expected.to eq(attrs) }
    end
  end
end
