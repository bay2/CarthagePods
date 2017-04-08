require "spec_helper"
require 'CocoaPodsManage'

describe 'getPlatformVersion' do


  it '# platform :ios, \'9.0\'' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
 # platform :ios, '9.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()


    relust = CocoaPodsManage.getPlatformVersion()

    expect(relust).to eq ''


  end

  it 'platform :ios, \'9.0\'' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()


    relust = CocoaPodsManage.getPlatformVersion()

    expect(relust).to start_with("'9.0'").and end_with("'9.0'")


  end

end