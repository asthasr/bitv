# coding: utf-8
lib = File.expand_path('./lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bitv"
  spec.version       = "0.1.0"
  spec.authors       = ["Blake Hyde"]
  spec.email         = ["syrion@gmail.com"]
  spec.summary       = %q{A library for packing boolean flags into 32-bit integer bitvectors for use with JavaScript.}
  spec.homepage      = "http://www.github.com/asthasr/bitv"
  spec.license       = "MIT"

  spec.files         = ["lib/bitv.rb"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
