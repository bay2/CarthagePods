require "spec_helper"
require 'Carthage/CarthageManage'

def podfileTestTmp(data)
  <<-SPEC
# Uncomment the next line to define a global platform for your project
#{data[:platform]}

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end
  SPEC

end

def podspecTestTmp(data)
  <<-SPEC
Pod::Spec.new do |s|
  s.name         = 'CarthagePods'
  s.version      = '1.0'
  s.summary      = 'A short description of CarthagePods.'
  s.description  = <<-DESC
                    LICENSE
                   DESC
  s.homepage     = 'http://EXAMPLE/CarthagePods'
  s.license      = 'MIT'
  s.author             = { 'CarthagePods' => 'CarthagePods@CarthagePods.com' }
  s.platform     = #{data[:platform]}
  s.source       = { :git => 'https://github.com/bay2/CarthagePods.git', :tag => '1.0' }
  s.vendored_frameworks = 'Carthage/Build/#{data[:platformPath]}/*.framework'
end
  SPEC

end

def podfileTest2Tmp

  <<-SPEC
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://git.coding.net/sim_cai/simSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

def ThreeThingsPod

  pod 'IBAnimatable', '~> 3.1.1'
  pod 'FSCalendar', '~> 2.7.1'

end

use_frameworks!

target 'ThreeThingsBeta' do

  ThreeThingsPod()

  target 'ThreeThingsBetaTests' do
      pod 'Quick', '~> 1.1.0'
      pod 'Nimble', '~> 6.0.1'
  end


end

target 'ThreeThings' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  ThreeThingsPod()

end
  SPEC

end

def podfileTest2ExpectTmp

  <<-SPEC
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://git.coding.net/sim_cai/simSpecs.git'
source 'https://github.com/CocoaPods/Specs.git'

def ThreeThingsPod

  pod 'IBAnimatable', '~> 3.1.1'
  pod 'FSCalendar', '~> 2.7.1'

end

use_frameworks!

target 'ThreeThingsBeta' do

  ThreeThingsPod()

  target 'ThreeThingsBetaTests' do
      pod 'Quick', '~> 1.1.0'
      pod 'Nimble', '~> 6.0.1'
  end


pod 'CarthagePods', :path => './'
end

target 'ThreeThings' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  ThreeThingsPod()

pod 'CarthagePods', :path => './'
end
  SPEC


end

describe 'getPlatformVersion' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }


  it 'comment line' do

    data = {}
    data[:platform] = "# platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformVersion

    expect(relust).to eq "'9.0'"


  end

  it 'ios 8.0' do

    data = {}
    data[:platform] = "platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformVersion

    expect(relust).to start_with("'8.0'").and end_with("'8.0'")

  end

end

describe 'insertCarthagePods' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }

  it 'single target' do

    data = {}
    data[:platform] = "platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    expectPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

pod 'CarthagePods', :path => './'
end
"
    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close

    cocoaManage.insertCarthagePods

    newPodfile = ""
    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines

    for line in lines
      newPodfile += line
    end

    podfile.close

    expect(expectPodFile).to eq(newPodfile)

  end

  it 'multiple target' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end

target 'test1' do

end"

    expectPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

pod 'CarthagePods', :path => './'
end

target 'test1' do

pod 'CarthagePods', :path => './'
end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close

    cocoaManage.insertCarthagePods

    newPodfile = ""
    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines

    for line in lines
      newPodfile += line
    end

    podfile.close

    expect(expectPodFile).to eq(newPodfile)

  end

  it 'nesting target' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

  target 'test3' do
  end

end

target 'test1' do

  target 'test4' do
  end

end"

    expectPodFile ="# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

  target 'test3' do
  end

pod 'CarthagePods', :path => './'
end

target 'test1' do

  target 'test4' do
  end

pod 'CarthagePods', :path => './'
end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.insertCarthagePods

    newPodfile = ""
    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines

    for line in lines
      newPodfile += line
    end

    podfile.close

    expect(expectPodFile).to eq(newPodfile)

  end

  it 'There are comments target' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

# target 'test3' do

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

  target 'test3' do
  end

end

target 'test1' do

  target 'test4' do
  end

end"

    expectPodFile ="# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

# target 'test3' do

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

  target 'test3' do
  end

pod 'CarthagePods', :path => './'
end

target 'test1' do

  target 'test4' do
  end

pod 'CarthagePods', :path => './'
end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close

    cocoaManage.insertCarthagePods()

    newPodfile = ""
    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines

    for line in lines
      newPodfile += line
    end

    podfile.close

    expect(expectPodFile).to eq(newPodfile)

  end

  context "ThreeThing Podfile" do

    it {

      podfileinit = podfileTest2Tmp
      expectPodfile = podfileTest2ExpectTmp

      podfile = File.new('Podfile', 'w+')
      podfile.write(podfileinit)
      podfile.close()

      cocoaManage.insertCarthagePods
      podfileinit = podfileTest2Tmp
      expectPodfile = podfileTest2ExpectTmp

      podfile = File.new('Podfile', 'w+')
      podfile.write(podfileinit)
      podfile.close()

      cocoaManage.insertCarthagePods

      newPodfile = ""
      podfile = File.new('Podfile', 'r')

      lines = podfile.readlines

      for line in lines
        newPodfile += line
      end

      podfile.close

      expect(expectPodfile).to eq(newPodfile)

    }

  end


end

describe 'reductionPodfile' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }

  it 'reduction podfile' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    expectPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close

    cocoaManage.insertCarthagePods
    cocoaManage.reductionPodfile

    newPodfile = ""
    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines

    for line in lines
      newPodfile += line
    end

    podfile.close

    expect(expectPodFile).to eq(newPodfile)

  end

end

describe 'getPlatformType' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }

  it 'comment line' do

    data = {}
    data[:platform] = "# platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformType

    expect(relust).to eq "ios"

  end

  it 'ios type' do

    data = {}
    data[:platform] = "platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformType

    expect(relust).to eq "ios"

  end

  it 'osx type' do

    data = {}
    data[:platform] = "platform :osx, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()


    relust = cocoaManage.getPlatformType

    expect(relust).to eq "osx"

  end

  it 'tvos type' do

    data = {}
    data[:platform] = "platform :tvos, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformType

    expect(relust).to eq "tvos"

  end

  it 'watchos type' do

    data = {}
    data[:platform] = "platform :watchos, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    relust = cocoaManage.getPlatformType

    expect(relust).to eq "watchos"

  end

end

describe 'generatePodspec' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }

  it 'comment line' do

    data = {}
    data[:platform] = "#platform :osx, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.generatePodspec
    podspecText = ""
    podspec = File.new 'CarthagePods.podspec', 'r'
    lines = podspec.readlines
    for line in lines
      podspecText += line
    end

    specData = {}
    specData[:platform] = ":ios, '9.0'"
    specData[:platformPath] = "iOS"

    expect(podspecTestTmp(specData)).to eq podspecText

  end

  it 'is osx' do

    data = {}
    data[:platform] = "platform :osx, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.generatePodspec
    podspecText = ""
    podspec = File.new 'CarthagePods.podspec', 'r'
    lines = podspec.readlines
    for line in lines
      podspecText += line
    end

    specData = {}
    specData[:platform] = ":osx, '8.0'"
    specData[:platformPath] = "Mac"

    expect(podspecTestTmp(specData)).to eq podspecText

  end

  it 'is ios' do

    data = {}
    data[:platform] = "platform :ios, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.generatePodspec
    podspecText = ""
    podspec = File.new 'CarthagePods.podspec', 'r'
    lines = podspec.readlines
    for line in lines
      podspecText += line
    end

    specData = {}
    specData[:platform] = ":ios, '8.0'"
    specData[:platformPath] = "iOS"

    expect(podspecTestTmp(specData)).to eq podspecText

  end

  it 'is tvos' do

    data = {}
    data[:platform] = "platform :tvos, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.generatePodspec
    podspecText = ""
    podspec = File.new 'CarthagePods.podspec', 'r'
    lines = podspec.readlines
    for line in lines
      podspecText += line
    end

    specData = {}
    specData[:platform] = ":tvos, '8.0'"
    specData[:platformPath] = "tvOS"

    expect(podspecTestTmp(specData)).to eq podspecText

  end

  it 'is watchos' do

    data = {}
    data[:platform] = "platform :watchos, '8.0'"
    initPodFile = podfileTestTmp(data)

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    cocoaManage.generatePodspec
    podspecText = ""
    podspec = File.new 'CarthagePods.podspec', 'r'
    lines = podspec.readlines
    for line in lines
      podspecText += line
    end

    specData = {}
    specData[:platform] = ":watchos, '8.0'"
    specData[:platformPath] = "watchOS"

    expect(podspecTestTmp(specData)).to eq podspecText

  end

end

describe 'platformToCarthagePath' do

  let(:cocoaManage) { CarthagePods::CocoaPodsManage.new }

  it 'osx' do

    relust = cocoaManage.platformToCarthagePath 'osx'

    expect(relust).to eq('Mac')

  end

  it 'ios' do

    relust = cocoaManage.platformToCarthagePath 'ios'

    expect(relust).to eq('iOS')

  end

  it 'tvos' do

    relust = cocoaManage.platformToCarthagePath 'tvos'

    expect(relust).to eq('tvOS')

  end

  it 'watchos' do

    relust = cocoaManage.platformToCarthagePath 'watchos'

    expect(relust).to eq('watchOS')

  end

end
