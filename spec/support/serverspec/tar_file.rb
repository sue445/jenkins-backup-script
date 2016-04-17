module Serverspec
  module Type
    class TarFile < Base
      def initialize(tar_file)
        # NOTE: @name is used in Serverspec::Type::Base
        @name = tar_file
      end

      def files
        return @files if @files

        command = "tar tfz #{@name}"
        result = Specinfra.backend.run_command(command)
        raise "FAILED: #{command}\n#{result.stderr}" if result.failure?

        @files = result.stdout.split(/[\r\n]+/)
      end

      def include?(file)
        files.include?(file)
      end
    end

    def tar_file(tar_file)
      TarFile.new(tar_file)
    end
  end
end

include Serverspec::Type
