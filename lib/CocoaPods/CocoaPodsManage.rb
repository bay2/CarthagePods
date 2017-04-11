require 'tty-command'

module CarthagePods

  class CocoaPodsManage

    def platformToCarthagePath(type)

      case type
        when 'osx'
          return 'Mac'
        when 'ios'
          return 'iOS'
        when 'tvos'
          return 'tvOS'
        when 'watchos'
          return 'watchOS'
        else
          return 'iOS'

      end

    end

    def spec_template(data)
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
  s.platform     = :#{data[:platformType]}, #{data[:version]}
  s.source       = { :git => 'https://github.com/bay2/CarthagePods.git', :tag => '1.0' }
  s.vendored_frameworks = 'Carthage/Build/#{platformToCarthagePath(data[:platformType])}/*.framework'
end
      SPEC

    end

    def generatePodspec

      version = getPlatformVersion
      platformType = getPlatformType
      data = {}
      data[:version] = version
      data[:platformType] = platformType

      podspec = spec_template data

      podspecFile = File.new('CarthagePods.podspec', 'w+')

      podspecFile.write podspec

      podspecFile.close

    end

    def readPodfile

      podfile = File.new('Podfile', 'r')

      lines = podfile.readlines

      podfile.close

      for line in lines

        if line =~ /0?(#)/
          next
        end

        yield line
      end

    end

    def getPlatformType

      readPodfile do |line|

        if line =~ /^\s*platform\s*:(\w*)\s*,\s*['"]\d*.\d*'\s*$/
          reslut = /^\s*platform\s*:(\w*)\s*,\s*['"]\d*.\d*'\s*$/.match(line)
          return reslut[1]
        end

      end

      return 'ios'

    end

    def getPlatformVersion

      readPodfile do |line|

        if line =~ /^\s*platform\s*:\w*\s*,\s*(['"]\d*.\d*['"])\s*$/
          reslut = /^\s*platform\s*:\w*\s*,\s*(['"]\d*.\d*['"])\s*$/.match(line)
          return reslut[1]
        end

      end

      return '\'9.0\''

    end

    def insertCarthagePods

      podfile = File.new('Podfile', 'r')

      curPodfile = podfile.readlines

      podfile.close

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

        if (line =~ /^\s*end\s*$/) && targetNum > 0

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

      podfile.close

    end

    def reductionPodfile

      podfile = File.new('Podfile', 'w+')

      podfile.write @podfileText

      podfile.close

    end

    def cocoaPodsInstall(arg={})

      insertCarthagePods

      cmdObj = TTY::Command.new
      cmd = 'pod install'

      arg.each_value do |value|
        cmd += " --#{value}"
      end


      cmdObj.run cmd

      reductionPodfile

    end

  end

end


