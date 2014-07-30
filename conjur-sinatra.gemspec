# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conjur/sinatra/version'

Gem::Specification.new do |spec|
  spec.name          = "conjur-sinatra"
  spec.version       = Conjur::Sinatra::VERSION
  spec.authors       = ["Kevin Gilpin"]
  spec.email         = ["kgilpin@conjur.net"]
  spec.description   = %q{Helper code for Conjur + Sinatra services}
  spec.summary       = %q{Helper code for Conjur + Sinatra services}
  spec.homepage      = "https://github.com/conjurinc/conjur-sinatra"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra'
  spec.add_dependency 'rack-test'
  spec.add_dependency 'rspec'

  spec.add_development_dependency 'conjur-cli'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'cucumber-sinatra'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
