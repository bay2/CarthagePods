require "CarthagePods/version"
require "DependencyCheck"
require 'clamp'
require 'CarthageManage'
require 'CocoaPodsManage'


module CarthagePods

  def self.checkEnv

    if !DependencyCheck.carthage?

      puts "Please install the Carhage. Uset commend \'sudo brew install carthage\'"

    end

    if !DependencyCheck.cocoapods?

      puts "Please install the Carhage. Uset commend \'sudo brew install carthage\'"

    end

  end

  class InstallCommand < Clamp::Command

    option "--no-checkout", :flag, "skip the checking out of dependencies after updating"

    option "--no-build", :flag, "skip the building of dependencies after updating
(ignored if --no-checkout option is present)"

    option "--verbose", :flag, "print xcodebuild output inline (ignored if --no-build option is present)"

    option "--configuration", "String", "the Xcode configuration to build')
(ignored if --no-build option is present)", :multivalued => true, :attribute_name => :configuration

    option "--platform", "platform", "the platforms to build for (one of 'all', 'macOS', 'iOS', 'watchOS', 'tvOS', or comma-separated values of the formers except for 'all')
(ignored if --no-build option is present)", :multivalued => true, :default => ["all"], :attribute_name => :platform

    option "--toolchain", "String", "the toolchain to build with", :multivalued => true, :attribute_name => :toolchain

    option "--derived-data", "String", "path to the custom derived data folder", :multivalued => true, :attribute_name => :derived_data

    option "--use-ssh", :flag, "use SSH for downloading GitHub repositories"

    option "--no-use-binaries", :flag, "check out dependency repositories even when prebuilt frameworks exist, disabled if --use-submodules option is present
(ignored if --no-build option is present)"


    def execute

      arg = {}

      if no_checkout?
        arg['no-checkout'] = 'no-checkout'
      end

      if no_build?
        arg['no-build'] = 'no-build'
      end

      if verbose?
        arg['verbose'] = 'verbose'
      end

      if configuration.join(' and ').length != 0
        arg['configuration'] = "configuration #{configuration.join(' and ')}"
      end

      if platform.join(' and ').length != 0
        arg['platform'] = "platform #{platform.join(' and ')}"
      end

      if toolchain.join(' and ').length != 0
        arg['toolchain'] = "toolchain #{platform.join(' and ')}"
      end

      if derived_data.join(' and ').length != 0
        arg['toolchain'] = "derived-data #{platform.join(' and ')}"
      end

      if use_ssh?
        arg['toolchain'] = "use-ssh"
      end

      if no_use_binaries?
        arg['no-use-binaries'] = "no-use-binaries"
      end

      CarthageManage.install(arg)

      CocoaPodsManage.generatePodspec()

    end

  end



  class MainCommand < Clamp::Command

    CarthagePods.checkEnv()

    subcommand 'install', 'Install project dependencies', InstallCommand

    subcommand "init", "Generate a Podfile and Cartfile for the current directory " do
      def execute
        CarthageManage.createCartfile()
        `pod init`
      end
    end



  end


end

if ENV['SPEC'] != '1'
  CarthagePods::MainCommand.run
end

