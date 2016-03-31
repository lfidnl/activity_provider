module ActivityProvider
  module LRS
    class ActivityDefinition < Base
      attribute :name, String
      attribute :description, String
      attribute :type, String
      attribute :more_info, String
      attribute :interaction_type, String
      attribute :correct_responses_pattern, [String]
      # TODO: Realize all types: choices | scale | source | target | steps

      def as_json(*_args)
        dumped_hash = {}
        dumped_hash[:moreInfo] = @more_info if @more_info
        dumped_hash[:interactionType] = @interaction_type if @interaction_type
        dumped_hash[:correctResponsesPattern] = @correct_responses_pattern if @correct_responses_pattern
        dumped_hash.merge!(dump_attributes(%i(name description type)))
        dumped_hash
      end
    end
  end
end
