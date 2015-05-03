# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bitv/version'

Gem::Specification.new do |spec|
  spec.name          = "bitv"
  spec.version       = Bitv::VERSION
  spec.authors       = ["Blake Hyde"]
  spec.email         = ["syrion@gmail.com"]
  spec.summary       = %q{A library for packing boolean flags into 32-bit integer bitvectors for use with JavaScript.}
  spec.homepage      = "http://www.github.com/asthasr/bitv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
end
