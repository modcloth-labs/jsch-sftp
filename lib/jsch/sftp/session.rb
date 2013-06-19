require_relative 'channel'

module Jsch
  module SFTP
    class Session
      attr_reader :channel

      def initialize(session, channel)
        @session, @channel = session, channel
      end

      def connected?
        session.is_connected
      end

      def download!(remote_filepath, local_filepath)
        channel.download!(remote_filepath, local_filepath)
      end

      def entries(remote_path)
        channel.entries(remote_path)
      end

      def upload!(local_filepath, remote_filepath)
        channel.upload!(local_filepath, remote_filepath)
      end

      def disconnect
        channel.disconnect unless channel.nil?

        if connected?
          session.disconnect rescue nil
        end
      end

      def self.connect(jsch, user, host, options)
        session = jsch.get_session(user, host)
        configure(session, options)
        session.connect

        channel = Channel.connect(session)

        self.new(session, channel)
      end

      private

      attr_reader :session

      def self.configure(session, options)
        session.set_password(options[:password]) if options.key?(:password)
        session.set_config("StrictHostKeyChecking", "no")
      end
    end
  end
end
