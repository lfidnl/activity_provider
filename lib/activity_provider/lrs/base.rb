module ActivityProvider
  module LRS
    class Base
      include Virtus.model

      def to_json(*args)
        as_json.to_json(*args)
      end

      def validate!
        raise "Invalid entity #{self.class}: #{errors.full_messages}" unless valid?
      end

      private

      def dump_attributes(attrs)
        dumped_hash = {}
        attrs.each do |attr|
          instance_variable_value = instance_variable_get(:"@#{attr}")
          dumped_hash[attr] = instance_variable_value if instance_variable_value
        end
        dumped_hash
      end
    end
  end
end
