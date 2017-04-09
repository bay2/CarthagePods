require 'tty-command'

class CocoaPodsManage

  def self.generatePodspec

    version = getPlatformVersion()

    podspec = "Pod::Spec.new do |s|
  s.name         = 'CarthagePods'
  s.version      = '1.0'
  s.summary      = 'A short description of CarthagePods.'
  s.description  = <<-DESC
                    LICENSE
                   DESC
  s.homepage     = 'http://EXAMPLE/ThreeThingsPods'
  s.license      = 'MIT'
  s.author             = { 'CarthagePods' => 'CarthagePods@CarthagePods.com' }
  s.platform     = :ios, #{version}
  s.source       = { :git => 'https://github.com/bay2/CarthagePods.git', :tag => '1.0' }
  s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  end"

    podspecFile = File.new('CarthagePods.podspec', 'w')

    podspecFile.write podspec

    podspecFile.close

  end

  def self.getPlatformVersion

    podfile = File.new('Podfile', 'r')

    lines = podfile.readlines()

    podfile.close()

    for line in lines

      if line =~ /0?(#)/
        next
      end

      if line =~ /\s*platform\s*:ios,\s*((['"])\d*.\d(['"]))/

        reslut = /['"]\d*.\d*['"]/.match(line)
        return reslut

      end

    end

    return "'9.0'"


  end

  def self.insertCarthagePods

    podfile = File.new('Podfile', 'r')

    curPodfile = podfile.readlines()

    podfile.close()

    targetNum = 0

    newPodFile = ''

    @podfileText = ""

    for line in curPodfile

      @podfileText += line

      if (line =~ /^\s*target\s*['"]\w*['"]\s*do\s*$/)
        targetNum += 1
        newPodFile += line
        next
      end

      if (line =~ /^\s*end\s*$/)

        targetNum -= 1

        if targetNum == 0
          newPodFile += ("pod 'CarthagePods', :path => './'\n")
        end

        newPodFile += line

        next

      end

      newPodFile += line

    end

    podfile = File.new('Podfile', 'w+')

    podfile.write newPodFile

    podfile.close()

  end

  def self.reductionPodfile

    podfile = File.new('Podfile', 'w+')

    podfile.write(@podfileText);

    podfile.close

  end

  def self.cocoaPodsInstall

    insertCarthagePods

    cmdObj = TTY::Command.new
    cmd = 'pod install'

    cmdObj.run cmd

    reductionPodfile

  end

end