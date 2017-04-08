Pod::Spec.new do |s|
  s.name         = 'ThreeThingsPods'
  s.version      = '1.0'
  s.summary      = 'A short description of ThreeThingsPods.'
  s.description  = <<-DESC
                    LICENSE
                   DESC
  s.author             = { 'CarthagePods' => 'Carthage@pods.com' }
  s.homepage     = 'http://EXAMPLE/ThreeThingsPods'
  s.license      = 'MIT'
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://git.coding.net/sim_cai/CarthagePods.git', :tag => '1.0'}
  s.vendored_frameworks = 'Carthage/Build/iOS/*.framework'
  end
