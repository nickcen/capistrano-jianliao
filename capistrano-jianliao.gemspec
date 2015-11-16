# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/jianliao/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-jianliao"
  gem.version       = Capistrano::Jianliao::VERSION
  gem.authors       = ["nickcen"]
  gem.email         = ["cenyongh@gmail.com"]
  gem.description   = %q{Send notifications to Jianliao about Capistrano deployments.}
  gem.summary       = %q{Send notifications to Jianliao about Capistrano deployments.}
  gem.homepage      = "https://github.com/nickcen/capistrano-jianliao"
  gem.license       = 'MIT'

  gem.required_ruby_version = '>= 2.0.0'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.0.1'
  gem.add_dependency 'json'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
