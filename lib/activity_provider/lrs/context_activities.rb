module ActivityProvider
  module LRS
    class ContextActivities < Base
      attribute :parent, [LRSObject]
      attribute :grouping, [LRSObject]
      attribute :category, [LRSObject]
      attribute :other, [LRSObject]

      def as_json(*_args)
        dump_attributes(%i(parent grouping category other))
      end
    end
  end
end
