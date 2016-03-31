# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activity_provider/version'

Gem::Specification.new do |spec|
  spec.name          = "activity_provider"
  spec.version       = ActivityProvider::VERSION
  spec.authors       = ["Ivan Kabluchkov"]
  spec.email         = ["ikabluchkov@gmail.com"]

  spec.summary       = %q{Activity Provider for LRS}
  spec.description   = %q{Activity Provider for store data of education in LRS (Learning Record Store) based on xAPI specification https://github.com/adlnet/xAPI-Spec/blob/master/xAPI.md}
  spec.homepage      = "https://github.com/lfidnl/activity_provider"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "fakeweb"

  spec.add_dependency('json')
  spec.add_dependency('virtus')
  spec.add_dependency('activesupport')
  spec.add_dependency('activemodel')
  spec.add_dependency('httparty')
end
