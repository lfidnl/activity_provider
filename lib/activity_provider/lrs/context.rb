module ActivityProvider
  module LRS
    class Context < Base
      attribute :registration, String
      attribute :instructor, Member
      attribute :team, Group
      attribute :context_activities, ContextActivities
      attribute :revision, String
      attribute :platform, String
      attribute :language, String
      attribute :statement, Statement
      attribute :extensions, JSON

      alias_method :contextActivities=, :context_activities=

      def as_json(*_args)
        dumped_hash = {}
        dumped_hash[:contextActivities] = @context_activities if @context_activities
        dumped_hash.merge!(dump_attributes(%i(registration instructor team revision
                                              platform language statement extensions)))
        dumped_hash
      end
    end
  end
end
