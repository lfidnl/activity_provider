module ActivityProvider
  module LRS
    class Statement < Base
      include ActiveModel::Validations

      attribute :actor, Member
      attribute :verb, Verb
      attribute :object, LRSObject
      attribute :result, Result
      attribute :context, Context
      attribute :id, String
      attribute :stored, DateTime

      validates :actor, :verb, :object, presence: true

      def initialize(*args)
        if args.first.is_a?(String)
          super(Statement.convert_json(args.first))
        else
          super(*args)
        end
      end

      def save
        if @id
          ActivityProvider::LRS::Client.new.send_statement(self)
        else
          ActivityProvider::LRS::Client.new.send_statements([self])
        end
      end

      def as_json(*_args)
        validate!
        dump_attributes(%i(actor verb object context result))
      end

      def self.find(id)
        ActivityProvider.fetch_statement(id)
      end

      # Converting JSON to Hash for easy using Virtus
      def self.convert_json(statement_json)
        statement_hash = JSON.parse(statement_json)
        actor = statement_hash['actor']
        if actor
          identifier = {}
          identifier['account'] = actor.delete('account')
          actor['identifier'] = identifier
        end
        verb = statement_hash['verb']
        if verb
          verb_name = verb['id'].match(%r{\/(\w*)$})
          verb['verb'] = verb_name[1]
        end

        statement_hash['actor'] = actor
        statement_hash['verb'] = verb
        statement_hash
      end
    end
  end
end
