require 'tty-command'

module CarthagePods



  class CarthageManage



    def createCartfile

      cartfile = '# Require version 2.3.1 or later
# github "ReactiveCocoa/ReactiveCocoa" >= 2.3.1

# Require version 1.x
# github "Mantle/Mantle" ~> 1.0    # (1.0 or later, but less than 2.0)

# Require exactly version 0.4.1
# github "jspahrsummers/libextobjc" == 0.4.1

# Use the latest version
# github "jspahrsummers/xcconfigs"

# Use the branch
# github "jspahrsummers/xcconfigs" "branch"

# Use a project from GitHub Enterprise
# github "https://enterprise.local/ghe/desktop/git-error-translations"

# Use a project from any arbitrary server, on the "development" branch
# git "https://enterprise.local/desktop/git-error-translations2.git" "development"

# Use a local project
# git "file:///directory/to/project" "branch"

# A binary only framework
# binary "https://my.domain.com/release/MyFramework.json" ~> 2.3'

      if File.exist?('Cartfile')
        return
      end

      cartAFile = File.new('Cartfile', 'w')

      cartAFile.write cartfile

      cartAFile.close

    end

    def install(arg={})

      cmdObj = TTY::Command.new
      cmd = 'carthage bootstrap'

      arg.each_value do |value|
        cmd += " --#{value}"
      end

      cmdObj.run cmd

    end





  end

end

