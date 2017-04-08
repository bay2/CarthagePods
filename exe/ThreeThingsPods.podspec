Pod::Spec.new do |s|
  s.name         = 'ThreeThingsPods'
  s.version      = '1.0'
  s.summary      = 'A short description of ThreeThingsPods.'
  s.description  = <<-DESC
                    LICENSE
                   DESC
  s.homepage     = 'http://EXAMPLE/ThreeThingsPods'
  s.license      = 'MIT'
  s.author             = { "蔡学敏" => "382499488@qq.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/bay2/CarthagePods.git', :tag => '1.0' }
  s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  end