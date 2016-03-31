module ActivityProvider
  class Configuration
    attr_accessor :xapi_url, :statement_path

    def initialize
      @statement_path ||= '/statements'
    end
  end
end
