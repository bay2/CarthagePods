
module CarthagePods

  class BuildCommand < Clamp::Command


    @@carthageArg = {}
    @@cocoapodsArg = {}


    option "--no-checkout", :flag, "skip the checking out of dependencies after updating" do
      @@carthageArg['no-checkout'] = 'no-checkout'
    end

    option "--no-build", :flag, "skip the building of dependencies after updating
(ignored if --no-checkout option is present)" do
      @@carthageArg['no-build'] = 'no-build'
    end

    option "--verbose", :flag, "print xcodebuild output inline (ignored if --no-build option is present)" do
      @@carthageArg['verbose'] = 'verbose'
      @@cocoapodsArg['verbose'] = 'verbose'
    end

    option "--configuration", "String", "the Xcode configuration to build')
(ignored if --no-build option is present)", :multivalued => true, :attribute_name => :configuration do |value|
      @@carthageArg['configuration'] = "configuration #{value}"
    end

    option "--toolchain", "String", "the toolchain to build with", :multivalued => true, :attribute_name => :toolchain do |value|
      @@carthageArg['toolchain'] = "toolchain #{value}"
    end

    option "--derived-data", "String", "path to the custom derived data folder", :multivalued => true, :attribute_name => :derived_data do |value|
      @@carthageArg['derived-data'] = "derived-data #{value}"
    end

    option "--use-ssh", :flag, "use SSH for downloading GitHub repositories" do
      @@carthageArg['use-ssh'] = "usr-ssh"
    end

    option "--no-use-binaries", :flag, "check out dependency repositories even when prebuilt frameworks exist, disabled if --use-submodules option is present
(ignored if --no-build option is present)" do
      @@carthageArg['no-use-binaries'] = 'no-use-binaries'
    end

    option "--repo-update", :flag, "Force running `pod repo update` before install" do
      @@cocoapodsArg['repo-update"'] = 'repo-update"'
    end

    option "--silent", :flag, "Show nothing" do
      @@cocoapodsArg['silent'] = 'silent'
    end

    option "--no-ansi", :flag, "Show output without ANSI codes" do
      @@cocoapodsArg['no-ansi'] = 'no-ansi'
    end

  end

end
