module ActivityProvider
  module LRS
    class Client
      include HTTParty
      DEFAULT_HEADERS = { 'Content-Type' => 'application/json' }
      base_uri ActivityProvider.config.xapi_url

      def send_statements(statements)
        response = self.class.post(ActivityProvider.config.statement_path,
                                   body: statements.to_json,
                                   headers: DEFAULT_HEADERS)
        if response.response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)
        else
          fail response.body
        end
      end

      def fetch_statement(statement_id)
        response = self.class.get("#{ActivityProvider.config.statement_path}?statementId=#{statement_id}",
                                  headers: DEFAULT_HEADERS)
        if response.response.is_a?(Net::HTTPSuccess)
          ActivityProvider::LRS::Statement.new(response.body)
        else
          fail response.body
        end
      end

      def save_statement(statement)
        response = self.class.put(ActivityProvider.config.statement_path,
                                   body: statement.to_json,
                                   headers: DEFAULT_HEADERS)
        fail response.body unless response.response.is_a?(Net::HTTPSuccess)
      end
    end
  end
end
