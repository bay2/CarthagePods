
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

  end

end


