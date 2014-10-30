# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commonjs/version'

Gem::Specification.new do |spec|
  spec.name          = "commonjs"
  spec.version       = CommonJS::VERSION
  spec.authors       = ["Nate Hunzaker"]
  spec.email         = ["nate.hunzaker@viget.com"]
  spec.description   = %q{Adds commonjs support using browserify to scan dependencies}
  spec.summary       = %q{Adds commonjs support using browserify to scan dependencies}
  spec.homepage      = "https://github.com/nhunzaker/commonjs-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sprockets", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails", "~> 3.2"
  spec.add_development_dependency "coffee-rails"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
end
