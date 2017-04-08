
class CocoaPodsManage

  def self.generatePodspec

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
  s.platform     = :ios, '9.0'
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

    return ''


  end

end