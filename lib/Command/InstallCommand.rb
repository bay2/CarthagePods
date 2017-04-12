require 'clamp'
require 'DependencyManagerTools/Carthage/CarthageManage'
require 'DependencyManagerTools/CocoaPods/CocoaPodsManage'
require 'Command/BuildCommand'

module CarthagePods

  class InstallCommand < BuildCommand



    def execute

      platformType = {"osx" => "macOS", "ios" => "iOS", "watchos" => "watchOS", "tvos" => "tvOS"}

      carthageManage = CarthageManage.new
      cocoaPodsManage = CocoaPodsManage.new
      cpodManage =  CPodManage.new


      @@carthageArg['platform'] = "platform #{platformType[cocoaPodsManage.getPlatformType]}"

      carthageManage.install @@carthageArg

      cpodManage.deleteFilterFramework cocoaPodsManage.platformToCarthagePath(cocoaPodsManage.getPlatformType)

      cocoaPodsManage.generatePodspec
      cocoaPodsManage.install @@cocoapodsArg

    end

  end

end
