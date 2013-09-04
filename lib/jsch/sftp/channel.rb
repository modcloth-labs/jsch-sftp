require_relative 'entry'

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

      def upload!(local_filepath, remote_filepath)
        channel.put(local_filepath, remote_filepath)
      end

      def mkdir(remote_path)
        channel.mkdir(remote_path)
      end

      def entries(remote_path)
        to_entries(channel.ls(remote_path))
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

      def to_entries(entries)
        entries.map { |e| to_entry(e) }
      end

      def to_entry(entry)
        Entry.new(entry.filename)
      end
    end
  end
end
