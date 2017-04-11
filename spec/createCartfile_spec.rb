require "spec_helper"
require 'CocoaPods/CocoaPodsManage'
require 'Carthage/CarthageManage'

describe 'create a cartfile' do

  it 'create file' do

    'rm -rf Cartfile'

    manage = CarthagePods::CarthageManage.new

    manage.createCartfile()
    reslut = File.exist? 'Cartfile'

    expect(reslut).to eq(true)

  end

end
