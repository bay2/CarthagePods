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
  s.platform     = :watchos, '8.0'
  s.source       = { :git => 'https://github.com/bay2/CarthagePods.git', :tag => '1.0' }
  s.vendored_frameworks = 'Carthage/Build/watchOS/*.framework'
end
