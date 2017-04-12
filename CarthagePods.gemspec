# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CarthagePods/version'

Gem::Specification.new do |spec|
  spec.name          = "CarthagePods"
  spec.version       = CarthagePods::VERSION
  spec.authors       = ["蔡学敏"]
  spec.email         = ["382499488@qq.com"]

  spec.summary       = "A simple, decentralized dependency manager for Cocoa"
  spec.description   = "A simple, decentralized dependency manager for Cocoa"
  spec.homepage      = "https://github.com/bay2/CarthagePods"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
#    raise "RubyGems 2.0 or newer is required to protect against " \
#      "public gem pushes."
#  end

  spec.files         = Dir["lib/**/*.rb"] + %w{exe/carthagePods LICENSE README.md}
  spec.bindir        = "exe"
  spec.executables   = %w{ carthagePods }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "clamp", "~> 1.1"
  spec.add_development_dependency "tty-command", "~> 0.4"
  spec.add_development_dependency "cocoapods", "~> 1.2"


end
