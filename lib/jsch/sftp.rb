require_relative 'sftp/session'

module Jsch
  module SFTP

    def self.start(host, user, options = {})
      begin
        session = connect(user, host, options)

        yield session
      rescue Exception => e
        raise e
      ensure
        session.disconnect unless session.nil?
      end
    end

    private

    def self.connect(user, host, options)
      jsch = com.jcraft.jsch.JSch.new
      configure(jsch, options)

      Session.connect(jsch, user, host, options)
    end

    def self.configure(jsch, options)
      jsch.add_identity(options[:identity]) if options.key?(:identity)
    end
  end
end
