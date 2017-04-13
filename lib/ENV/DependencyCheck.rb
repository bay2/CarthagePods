require 'pastel'
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

  def self.checkEnv

    if !DependencyCheck.carthage?
      pastel =  Pastel.new
      puts pastel.red('[Error] Please install the Carhage. Use commend') + pastel.green(" [sudo] brew install carthage")
    end

    if !DependencyCheck.cocoapods?
      pastel =  Pastel.new
      puts pastel.red('[Error] Please install the Cocoapods. Use commend') + pastel.green(" [sudo] gem install cocoapods")
    end

  end


end
