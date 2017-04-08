require "spec_helper"
require 'CarthagePods'
require 'CarthageManage'

describe 'create a cartfile' do

  it 'create file' do

    'rm -rf Cartfile'

    CarthageManage.createCartfile()
    reslut = File.exist? 'Cartfile'

    expect(reslut).to eq(true)

  end

end