
module CarthagePods

  class ToolsManger

    def argMarge(cmd, arg={})

      arg.each_value do |value|
        cmd += " --#{value}"
      end

      return cmd

    end

  end

end

