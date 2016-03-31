module ActivityProvider
  module LRS
    class Member < Base
      attribute :name, String
      attribute :object_type, String, default: 'Agent'
      attribute :identifier, Identifier

      alias_method :objectType, :object_type
      alias_method :objectType=, :object_type=

      def as_json(*_args)
        dumped_hash = { objectType: @object_type }
        dumped_hash[:name] = @name if @name
        dumped_hash.merge!(@identifier.as_json)
        dumped_hash
      end
    end
  end
end
