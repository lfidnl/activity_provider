module ActivityProvider
  module LRS
    class Verb < Base
      XAPI_VERBS_REFERENCE = 'http://www.adlnet.gov/expapi/verbs/'

      attribute :verb, String

      def as_json(*_args)
        {
          id: XAPI_VERBS_REFERENCE + @verb,
          display: { :"en-US" => @verb }
        }
      end
    end
  end
end
