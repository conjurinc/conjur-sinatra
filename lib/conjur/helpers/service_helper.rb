module Conjur
  module Helpers
    module ServiceHelper
      def conjur_service_api
        if ENV['CONJUR_SERVICE_LOGIN'] && ENV['CONJUR_SERVICE_API_KEY']
          # Login from environment
          Conjur::API.new_from_key service_login, service_api_key
        else
          # Login from .netrc
          require 'conjur/cli'
          require 'conjur/authn'
          Conjur::Authn.connect
        end
      end
      
      def policy_id
        ENV['CONJUR_POLICY_ID'] || policy['policy']
      end
      
      def policy
        JSON.parse File.read(policy_file_name)
      end
      
      def policy_file_name
        'policy.json'
      end
    end
  end
end