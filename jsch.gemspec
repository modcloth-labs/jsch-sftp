# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jsch/version'

Gem::Specification.new do |gem|
  gem.name          = "jsch-sftp"
  gem.version       = Jsch::VERSION
  gem.authors       = ['Pat Bair']
  gem.email         = ['bi+jsch@modcloth.com']
  gem.description   = %q{Jsch wrapper for JRuby}
  gem.summary       = %q{Wraps Jsch library for easy JRuby usage}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
