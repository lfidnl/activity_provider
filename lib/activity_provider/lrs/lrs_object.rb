module ActivityProvider
  module LRS
    class LRSObject < Base
      include ActiveModel::Validations

      attribute :id, String
      attribute :object_type, String
      attribute :definition, ActivityDefinition

      validates :id, presence: true
      validates :object_type, inclusion: { in: %w(Activity Statement StatementRef
                                                  SubSatement Agent Group) }

      def initialize(args)
        super
        @object_type ||= 'Activity'
      end

      def as_json(*_args)
        validate!
        dumped_hash = {
          id: @id,
          objectType: @object_type
        }
        dumped_hash[:definition] = @definition if @definition && !@definition.empty?
        dumped_hash
      end
    end
  end
end
