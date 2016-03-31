require 'json'
require 'virtus'
require 'active_model'
require 'active_support/dependencies/autoload'
require 'active_support/concern'
require 'activity_provider/version'
require 'activity_provider/configuration'
require 'httparty'

module ActivityProvider
  module LRS
    extend ActiveSupport::Autoload
    eager_autoload do
      autoload :Base
      autoload :Verb
      autoload :Account
      autoload :Identifier
      autoload :Member
      autoload :Group
      autoload :LRSObject
      autoload :Score
      autoload :Result
      autoload :ContextActivities
      autoload :Statement
      autoload :Context
      autoload :ActivityDefinition
      autoload :Client

      module Validators
        extend ActiveSupport::Autoload
        autoload :IRLValidator
      end
    end
  end

  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end
  end
end
