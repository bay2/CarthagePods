require "spec_helper"
require 'CPod/CPodManage'

describe 'CPodManage' do

  cpodManage = CarthagePods::CPodManage.new


  it 'should Create CPodfile' do



    cpodManage.createCPodfile

    cpodfile = File.new 'CPodfile', 'r'
    lines = cpodfile.readlines

    cpodfileText = ""

    for line in lines
      cpodfileText += line
    end

    expectText = cpodManage.CPodfile_template

    expect(cpodfileText).to eq expectText

  end

  after() do
    cpodManage.deleteCPodfile

  end


end
