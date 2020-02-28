# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CarthagePods/version'

Gem::Specification.new do |spec|
  spec.name          = "CarthagePods"
  spec.version       = CarthagePods::VERSION
  spec.authors       = ["sim"]
  spec.email         = ["sim_cai@icloud.com"]

  spec.summary       = "A simple, decentralized dependency manager for Cocoa"
  spec.description   = "A simple, decentralized dependency manager for Cocoa"
  spec.homepage      = "https://github.com/bay2/CarthagePods"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb"] + %w{exe/carthagePods LICENSE README.md}
  spec.bindir        = "exe"
  spec.executables   = %w{ carthagePods }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "clamp", "~> 1.1"
  spec.add_runtime_dependency "tty-command", "~> 0.4"
  spec.add_runtime_dependency "cocoapods", "~> 1.2"
  #sepc.add_runtime_dependency "paint", "~> 2.0"


end
