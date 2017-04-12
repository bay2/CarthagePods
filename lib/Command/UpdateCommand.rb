require 'clamp'
require 'Command/BuildCommand'
require 'DependencyManagerTools/CocoaPods/CocoaPodsManage'
require 'DependencyManagerTools/Carthage/CarthageManage'

module CarthagePods


  class UpdateCommand < BuildCommand

    def execute

      platformType = {"osx" => "macOS", "ios" => "iOS", "watchos" => "watchOS", "tvos" => "tvOS"}

      cocoaPodsManage = CocoaPodsManage.new
      carthageManage = CarthageManage.new

      @@carthageArg['platform'] = "platform #{platformType[cocoaPodsManage.getPlatformType]}"

      carthageManage.update @@carthageArg
      cocoaPodsManage.update @@cocoapodsArg

    end

  end

end
