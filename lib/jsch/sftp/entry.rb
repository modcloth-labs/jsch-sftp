module Jsch
  module SFTP
    class Entry

      attr_reader :name

      def initialize(name)
        @name = name
      end
    end
  end
end
