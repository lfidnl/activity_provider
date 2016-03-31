require 'spec_helper'

RSpec.describe ActivityProvider::LRS::Statement do
  let(:identifier) { ActivityProvider::LRS::Identifier.new(mbox: 'test@email.com') }
  let(:actor) { ActivityProvider::LRS::Member.new(identifier: identifier) }
  let(:verb) { ActivityProvider::LRS::Verb.new(verb: 'answered') }
  let(:object) { ActivityProvider::LRS::LRSObject.new(id: 'http://some/id') }

  def valid_attributes
    { actor: actor, verb: verb, object: object }
  end

  describe '#as_json' do
    subject { described_class.new(valid_attributes).as_json }

    it { is_expected.to eq(valid_attributes) }
  end

  describe '.convert_json' do
    let(:statement_json) do
      '{"id":"da3b6ac8-02f1-4ad5-9d7e-a34bde57404e","actor":{"objectType":"Agent",'\
      '"account":{"homePage":"http://somehost/users","name":"441719"}},'\
      '"verb":{"id":"http://www.adlnet.gov/expapi/verbs/answered","display":{"en-US":"answered"}},'\
      '"object":{"id":"http://somehost/23918","objectType":"Activity"},'\
      '"result":{"success":false,"completion":false,"response":'\
      '"[{\"name\":\"test 1\",\"index\":1,\"user_answers\":[],\"group_names\":[]},{\"name\":\"test 2\"'\
      ',\"index\":2,\"user_answers\":[],\"group_names\":[]}]","score":{"raw":0.0}},'\
      '"context":{"contextActivities":{"parent":[{"id":"http://somehost/5"}]}},'\
      '"stored":"2016-03-04T11:17:27Z"}'
    end

    subject { ActivityProvider::LRS::Statement.new(statement_json) }

    it { expect(subject.id).to eq('da3b6ac8-02f1-4ad5-9d7e-a34bde57404e') }

    context 'actor' do
      let(:actor) { subject.actor }

      it { expect(actor.object_type).to eq('Agent') }

      context 'identifier' do
        let(:identifier) { actor.identifier }

        context 'account' do
          let(:account) { identifier.account }

          it { expect(account.home_page).to eq('http://somehost/users') }
          it { expect(account.name).to eq('441719') }
        end
      end
    end

    context 'verb' do
      let(:verb) { subject.verb }

      it { expect(verb.verb).to eq('answered') }
    end

    context 'context' do
      let(:context_object) { subject.context }

      it { expect(context_object.context_activities).to_not be_nil }

      context 'context activities' do
        let(:context_activities) { context_object.context_activities }

        it { expect(context_activities.parent).to_not be_empty }
      end
    end
  end
end
