
class DependencyCheck

  def self.carthage?

    out = `carthage`
    return DependencyCheck.checkIfInstallCarthage(out)

  end

  def self.checkIfInstallCarthage(out)

    if (out =~ /\w*\W*\s*command not found\s*\w*\W*/)
      return false
    else
      return true
    end

  end

end