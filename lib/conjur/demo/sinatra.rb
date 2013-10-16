require "conjur/demo/sinatra/version"

module Conjur
  module Demo
    module Sinatra
      def self.extended(base)
        base.class_eval do
          class << self
            def configure!
              $config = YAML.load(File.read('config.yml'))
              
              ENV['CONJUR_ENV'] = $config[:env]
              ENV['CONJUR_STACK'] = $config[:stack]
              ENV['CONJUR_ACCOUNT'] = $config[:account]
            end
          end

          helpers do
            def account; $config[:account]; end
            def namespace;  $config[:namespace];  end
          
            def request_headers
              env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
            end
          
            def parse_authorization
              token = request_headers['authorization']
              halt(401) unless token
              halt(403) unless token.to_s[/^Token token="(.*)"/]
              token = JSON.parse(Base64.decode64($1))
              @api = Conjur::API::new_from_token token
            end
          end

          before do
            parse_authorization
          end
        end
      end
    end
  end
end