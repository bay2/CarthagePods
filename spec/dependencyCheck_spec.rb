require "spec_helper"
require 'DependencyCheck'

describe 'My behaviour' do

  it 'not found carthage' do


    input = 'zsh: command not found: Carthage'

    result = DependencyCheck.checkIfInstallCarthage(input)


    expect(result).to eq(false)

  end

  it 'found carthage' do

    input = "vailable commands:

   archive           Archives built frameworks into a zip that Carthage can use
   bootstrap         Check out and build the project's dependencies
   build             Build the project's dependencies
   checkout          Check out the project's dependencies
   copy-frameworks   In a Run Script build phase, copies each framework specified by a SCRIPT_INPUT_FILE environment variable into the built app bundle
   fetch             Clones or fetches a Git repository ahead of time
   help              Display general or command-specific help
   outdated          Check for compatible updates to the project's dependencies
   update            Update and rebuild the project's dependencies
   version           Display the current version of Carthage"

    result = DependencyCheck.checkIfInstallCarthage(input)

    expect(result).to eq(true)


  end

end