# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beepsend/version'

Gem::Specification.new do |spec|
  spec.name          = 'beepsend'
  spec.version       = Beepsend::VERSION
  spec.authors       = ['Anatoliy Kukul']
  spec.email         = ['anatoliy.kukul@herogaming.com']

  spec.summary       = %q{For sending SMS using Beepsend API}
  spec.description   = %q{Simple gem that implements sending SMS using Beepsend API api.beepsend.com/docs.html}
  spec.homepage      = 'https://github.com/RushPlay/beepsend'
  spec.files         = `git ls-files -z`.split("\0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
end
