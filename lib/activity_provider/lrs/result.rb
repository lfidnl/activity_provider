module ActivityProvider
  module LRS
    class Result < Base
      include ActiveModel::Validations

      attribute :success, Boolean
      attribute :completion, Boolean
      attribute :response, String
      attribute :score, Score
      attribute :duration, String
      # TODO: add Extension

      validates :duration, format: {
        with: /P(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})/
      }, allow_blank: true

      def as_json(*_args)
        validate!
        dump_attributes(%i(response success completion score duration))
      end
    end
  end
end
