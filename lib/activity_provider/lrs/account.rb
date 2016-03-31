module ActivityProvider
  module LRS
    class Account < Base
      include ActiveModel::Validations

      attribute :home_page, String
      attribute :name, String

      validates_with Validators::IRLValidator, fields: [:home_page]

      alias_method :homePage=, :home_page=

      def as_json(*_args)
        validate!
        {
          homePage: @home_page,
          name: @name
        }
      end
    end
  end
end
