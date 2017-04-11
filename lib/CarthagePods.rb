require "CarthagePods/version"
require "ENV/DependencyCheck"
require 'clamp'
require 'Command/InstallCommand'
require 'Command/MainCommand'


module CarthagePods

end

if ENV['SPEC'] != '1'
  CarthagePods::MainCommand.run
end

