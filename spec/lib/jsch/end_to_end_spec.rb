require_relative '../../../lib/jsch/init'
require_relative '../../../lib/jsch/sftp'
require 'tmpdir'

describe Jsch::SFTP do
  let(:host) { 'localhost' }
  let(:user) { ENV['USER'] }

  before(:all) do
    @sourcedir = File.join(File.expand_path(File.dirname(__FILE__)), '../../')
    @destdir = Dir.mktmpdir('sftp_work')

    home = Java::JavaLang::System.get_property('user.home')
    @identity = File.join(home, '.ssh/id_rsa')
  end

  context "downloading a file" do
    it "should download the given remote file to the given local path" do
      remote_file = File.join(@sourcedir, 'test.tgz')
      local_file = File.join(@destdir, 'test.tgz.down')

      described_class.start(host, user, identity: @identity) do |sftp|
        sftp.download!(remote_file, local_file)
      end

      File.exists?(local_file).should be_true
    end
  end

  context "uploading a file" do
    it "should upload the given local file to the given remote path" do
      local_file = File.join(@sourcedir, 'test.tgz')
      remote_file = File.join(@destdir, 'test.tgz.up')

      described_class.start(host, user, identity: @identity) do |sftp|
        sftp.upload!(local_file, remote_file)
      end

      File.exists?(remote_file).should be_true
    end
  end
end
