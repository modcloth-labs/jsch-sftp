require_relative '../../../lib/jsch/init'
require_relative '../../../lib/jsch/sftp'
require 'tmpdir'

describe Jsch::SFTP do
  let(:host) { 'localhost' }
  let(:user) { ENV['USER'] }

  before(:all) do
    @localdir = File.join(File.expand_path(File.dirname(__FILE__)), '../../')
    @tmpdir = Dir.mktmpdir('sftp_work')

    @remote_file = File.join(@localdir, 'test.tgz')
    @local_file = File.join(@tmpdir, 'test.tgz')
  end

  context "downloading a file" do
    it "should download the given remote file to the given local path" do
      home = Java::JavaLang::System.get_property('user.home')
      identity = File.join(home, '.ssh/id_rsa')

      described_class.start(host, user, identity: identity) do |sftp|
        sftp.download!(@remote_file, @local_file)
      end

      File.exists?(@local_file).should be_true
    end
  end
end
