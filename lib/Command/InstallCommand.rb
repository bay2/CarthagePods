require 'clamp'
require 'Carthage/CarthageManage'
require 'CocoaPods/CocoaPodsManage'

module CarthagePods

  class InstallCommand < Clamp::Command

    option "--no-checkout", :flag, "skip the checking out of dependencies after updating"

    option "--no-build", :flag, "skip the building of dependencies after updating
(ignored if --no-checkout option is present)"

    option "--verbose", :flag, "print xcodebuild output inline (ignored if --no-build option is present)"

    option "--configuration", "String", "the Xcode configuration to build')
(ignored if --no-build option is present)", :multivalued => true, :attribute_name => :configuration

    option "--toolchain", "String", "the toolchain to build with", :multivalued => true, :attribute_name => :toolchain

    option "--derived-data", "String", "path to the custom derived data folder", :multivalued => true, :attribute_name => :derived_data

    option "--use-ssh", :flag, "use SSH for downloading GitHub repositories"

    option "--no-use-binaries", :flag, "check out dependency repositories even when prebuilt frameworks exist, disabled if --use-submodules option is present
(ignored if --no-build option is present)"

    option "--repo-update", :flag, "Force running `pod repo update` before install"

    option "--silent", :flag, "Show nothing"

    option "--no-ansi", :flag, "Show output without ANSI codes"


    def execute

      carthageArg = {}
      cocoapodsArg = {}

      if no_checkout?
        carthageArg['no-checkout'] = 'no-checkout'
      end

      if no_build?
        carthageArg['no-build'] = 'no-build'
      end

      if verbose?
        carthageArg['verbose'] = 'verbose'
        cocoapodsArg['verbose'] = 'verbose'
      end

      if configuration.join(' and ').length != 0
        carthageArg['configuration'] = "configuration #{configuration.join(' and ')}"
      end


      if toolchain.join(' and ').length != 0
        carthageArg['toolchain'] = "toolchain #{platform.join(' and ')}"
      end

      if derived_data.join(' and ').length != 0
        carthageArg['toolchain'] = "derived-data #{platform.join(' and ')}"
      end

      if use_ssh?
        carthageArg['toolchain'] = "use-ssh"
      end

      if no_use_binaries?
        carthageArg['no-use-binaries'] = "no-use-binaries"
      end

      if repo_update?
        cocoapodsArg['repo-update'] = "repo-update"
      end

      if silent?
        cocoapodsArg['silent'] = "silent"
      end

      if no_ansi?
        cocoapodsArg['no-ansi'] = 'no-ansi'
      end

      platformType = {"osx" => "macOS", "ios" => "iOS", "watchos" => "watchOS", "tvos" => "tvOS"}

      carthageManage = CarthageManage.new
      cocoaPodsManage = CocoaPodsManage.new
      cpodManage =  CPodManage.new

      carthageArg[:platform] = "platform #{platformType[cocoaPodsManage.getPlatformType]}"


      carthageManage.install carthageArg

      cpodManage.deleteFilterFramework cocoaPodsManage.platformToCarthagePath(cocoaPodsManage.getPlatformType)

      cocoaPodsManage.generatePodspec
      cocoaPodsManage.cocoaPodsInstall cocoapodsArg

    end

  end

end
