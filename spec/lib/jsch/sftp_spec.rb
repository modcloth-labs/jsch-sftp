require_relative '../../../lib/jsch/init'
require_relative '../../../lib/jsch/sftp'

describe Jsch::SFTP do

  context "opening a remote connection" do
    let(:sftp) { double('sftp', disconnect: nil) }

    before(:each) do
      described_class.stub(:connect).and_return(sftp)
    end

    context "when the commands complete successfully" do
      it "should automatically close the connection" do
        sftp.should_receive(:disconnect)

          described_class.start('host', 'user') do |sftp|
            # noop
          end
      end
    end

    context "when an error occurs while executing one of the commands" do
      it "should automatically close the connection" do
        sftp.should_receive(:disconnect)

        begin
          described_class.start('host', 'user') do |sftp|
            raise StandardError
          end
        rescue
        end
      end

      it "should re-raise the error" do
        expect {
          described_class.start('host', 'user') do |sftp|
            raise StandardError
          end
        }.to raise_error
      end
    end
  end
end
