
class DependencyCheck

  def self.carthage?
    checkComponent 'carthage'
  end

  def self.cocoapods?
    checkComponent 'pod'
  end

  def self.checkComponent(name)

    exts = ENV['PATH'] ? ENV['PATH'].split(':') : ['']

    exts.each do |path|

      ext = "#{path}/#{name}"
      if File.executable?(ext) && !File.directory?(ext)
        return true
      end

    end

    return false

  end


end