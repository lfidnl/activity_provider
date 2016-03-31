module ActivityProvider
  module LRS
    module Validators
      class IRLValidator < ActiveModel::Validator
        def validate(object)
          options[:fields].each do |field|
            unless object.send(field) =~ %r(^https?:\/\/.*)
              object.errors.add(field, 'wrong format')
            end
          end
        end
      end
    end
  end
end
