module ActivityProvider
  module LRS
    class Group < Base
      attribute :name, String
      attribute :object_type, String
      attribute :identifier, Identifier
      attribute :members, Array[Member]

      def initialize(args)
        @object_type = 'Group'
        super
      end

      def as_json(*_args)
        dumped_hash = { objectType: @object_type }
        dumped_hash[:name] = @name if @name
        dumped_hash[:member] = @members if @members && !@members.empty?
        dumped_hash.merge!(@identifier.as_json)
        dumped_hash
      end
    end
  end
end
