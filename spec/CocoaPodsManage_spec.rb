require "spec_helper"
require 'CocoaPodsManage'

describe 'getPlatformVersion' do


  it '# platform :ios, \'9.0\'' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
 # platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()


    relust = CocoaPodsManage.getPlatformVersion()

    expect(relust).to eq "'9.0'"


  end

  it 'platform :ios, \'9.0\'' do

    initPodFile = "# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'test' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for test

end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()


    relust = CocoaPodsManage.getPlatformVersion()

    expect(relust).to start_with("'8.0'").and end_with("'8.0'")

  end

end

describe 'insertCarthagePods' do

  it 'single target' do

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

pod 'CarthagePods', :path => './'
end"

    podfile = File.new('Podfile', 'w+')
    podfile.write(initPodFile)
    podfile.close()

    CocoaPodsManage.insertCarthagePods()

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
    podfile.close()

    CocoaPodsManage.insertCarthagePods()

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

    CocoaPodsManage.insertCarthagePods()

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
    podfile.close()

    CocoaPodsManage.insertCarthagePods()

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

describe 'reductionPodfile' do

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
    podfile.close()

    CocoaPodsManage.insertCarthagePods
    CocoaPodsManage.reductionPodfile

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