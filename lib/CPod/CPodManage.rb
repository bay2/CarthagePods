
module CarthagePods

  class CPodManage

    def CPodfile_template()
      <<-SPEC
# filterFramework ['RxTest.framework', 'RxBlocking.framework']
      SPEC
    end

    def createCPodfile()

      cpodfile = File.new 'CPodfile', 'w'

      cpodfile.write(CPodfile_template())

      cpodfile.close

    end

    def deleteCPodfile()
      File.delete'CPodfile'
    end

    def deleteFilterFramework(platformPath)

      require 'CPod/EvalFilterFramework'

      $filterHash_value.each_value do |value|

        path = "Carthage/Build/#{platformPath}/#{value}"

        `rm -rf #{path}`

      end

    end

  end

end


