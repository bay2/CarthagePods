
class DependencyCheck

  def self.checkIfInstallCarthage

    out = `carthage`

    if (out =~ /\w*\W*\s*command not found\s*\w*\W*/)
      return false
    else
      return true
    end

  end


end