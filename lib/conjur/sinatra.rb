require "conjur/sinatra/version"
require 'rack/logger'
require 'conjur/helpers/service_helper'

module Conjur
  module Sinatra
    def self.extended(base)
      base.class_eval do
        helpers Conjur::Helpers::ServiceHelper
        
        configure do
          enable :logging
          use Rack::Logger
        end
        
        before do
          if settings.production?
            env['rack.errors'] = $stdout
          else
            logdir = "log"
            `mkdir -p #{logdir}` unless File.directory?(logdir)
            env['rack.errors'] = File.open("#{logdir}/#{settings.environment}.log", "a")
          end
        end
        
        helpers do
          def param! name
            params[name.to_sym] or halt(400, "Parameter '#{name}' is missing")
          end

          def conjur_client_api
            @conjur_client ||= parse_authorization
          end
          
          def request_headers
            env.inject({}){|acc, (k,v)| acc[$1.downcase] = v if k =~ /^http_(.*)/i; acc}
          end
        
          def parse_authorization
            token = request_headers['authorization']
            halt(401) unless token
            halt(403) unless token.to_s[/^Token token="(.*)"/]
            token = JSON.parse(Base64.decode64($1))
            Conjur::API::new_from_token token
          end
        end
      end
    end
  end
end