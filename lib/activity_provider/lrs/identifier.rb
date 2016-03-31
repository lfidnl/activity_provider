module ActivityProvider
  module LRS
    class Identifier < Base
      include ActiveModel::Validations

      MAILTO = 'mailto:'

      attribute :mbox, String
      attribute :mbox_sha1sum, String
      attribute :openid, String
      attribute :account, Account

      validates :mbox, format: { with: %r(\Amailto:.*@.*) }, allow_nil: true

      def as_json(*_args)
        normalize_mbox
        validate!
        dump_attributes(%i(mbox mbox_sha1sum openid account))
      end

      private

      def normalize_mbox
        return unless @mbox
        @mbox.prepend(MAILTO) unless @mbox.start_with?(MAILTO)
      end
    end
  end
end
