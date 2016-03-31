module ActivityProvider
  module LRS
    class Score < Base
      include ActiveModel::Validations

      attribute :scaled, Float
      attribute :raw, Float
      attribute :min, Float
      attribute :max, Float

      validates :scaled, inclusion: { in: -1..1 }, allow_nil: true

      def as_json(*_args)
        validate!
        dump_attributes(%i(scaled raw min max))
      end
    end
  end
end
