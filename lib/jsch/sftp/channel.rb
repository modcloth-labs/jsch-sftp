module Jsch
  module SFTP
    class Channel

      def initialize(channel)
        @channel = channel
      end

      def connected?
        channel.is_connected
      end

      def download!(remote_filepath, local_filepath)
        channel.get(remote_filepath, local_filepath)
      end

      def disconnect
        if connected?
          channel.disconnect rescue nil
        end
      end

      def self.connect(session)
        channel = session.open_channel("sftp")
        channel.connect

        self.new(channel)
      end

      private

      attr_reader :channel

    end
  end
end
