# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fuzzy_string/version'

Gem::Specification.new do |spec|
  spec.name          = "fuzzy_string"
  spec.version       = FuzzyString::VERSION
  spec.authors       = ["Chris Moody"]
  spec.email         = ["cmoody@transcon.com"]
  spec.summary       = %q{Relative ranking system for strings.}
  spec.description   = %q{A ranking system for strings.  The rank by itself is arbitrary and only has context /
                         when compared to other ranks.  The base score is the levenschtein distance which is /
                         modified by other basic matching criteria.}
  spec.homepage      = "https://github.com/transcon/fuzzy_string"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'minitest-reporters',  '>= 1.0.1'
end
