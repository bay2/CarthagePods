require "spec_helper"
require 'DependencyManagerTools/CocoaPods/CocoaPodsManage'
require 'DependencyManagerTools/Carthage/CarthageManage'

describe 'create a cartfile' do

  it 'create file' do

    'rm -rf Cartfile'

    manage = CarthagePods::CarthageManage.new

    manage.createCartfile()
    reslut = File.exist? 'Cartfile'

    expect(reslut).to eq(true)

  end

end
