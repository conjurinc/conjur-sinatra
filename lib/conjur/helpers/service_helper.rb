module Conjur
  module Helpers
    module ServiceHelper
      def conjur_service_api
        require 'conjur/cli'
        require 'conjur/authn'
        # Will login from CONJUR_AUTHN_LOGIN and CONJUR_AUTHN_API_KEY if available in the environment.
        Conjur::Authn.connect
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