require "spec_helper"
require 'DependencyCheck'

describe 'My behaviour' do

  it 'checkCommend is true' do


    input = 'carthage'

    result = DependencyCheck.checkComponent(input)


    expect(result).to eq(true)

  end

  it 'checkCommend is false' do

    input = 'lss'

    result = DependencyCheck.checkComponent(input)

    expect(result).to eq(false)

  end

end