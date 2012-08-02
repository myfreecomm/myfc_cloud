# encoding: utf-8
require 'spec_helper'

describe MyfcCloud::Commands::ScalingGroup do
  let(:configuration) { MyfcCloud::Configuration.new(yaml_fixture_path('configuration_full')) }
  let(:mock_asg) { mock('scaling_group').as_null_object }
  subject { described_class.new(configuration) }

  describe '#scaling_group' do
    it "should return an (memoized) instance of the auto scaling group" do
      # values from configuration_full.yml
      AWS::AutoScaling.should_receive(:new).with(
        :access_key_id => 'SANDBOX_ACCESS_KEY_ID',
        :secret_access_key => 'SANDBOX_SECRET_ACCESS_KEY'
      ).and_return(mock_aws_asg_interface = mock('AWS::AutoScaling'))
      mock_aws_asg_interface.should_receive(:groups).and_return(mock_aws_asg_groups = mock('AWS::AutoScaling::GroupCollection'))
      mock_aws_asg_groups.should_receive(:[]).with('sandbox_asg').and_return(mock_asg)

      subject.send(:scaling_group).should == mock_asg
      subject.send(:scaling_group).should == mock_asg # again to test the memoization
    end
  end

  describe '#check_existence!' do
    before(:each) do
      subject.stub(:scaling_group).and_return(mock_asg)
    end
    it "should not raise error if the auto scaling group exists" do
      mock_asg.should_receive(:exists?).and_return(true)
      subject.send(:check_existence!).should be_nil
    end
    it "should raise an error if the auto scaling group does not exist" do
      mock_asg.should_receive(:exists?).and_return(false)
      expect { subject.send(:check_existence!) }.to raise_error(RuntimeError, "AutoScalingGroup named 'sandbox_asg' does not exist")
    end
  end

  describe '#update' do
    before(:each) do
      subject.stub(:scaling_group).and_return(mock_asg)
      subject.stub(:check_existence!).and_return(true)
    end
    it "should update the auto scaling group with the (valid) supplied options" do
      mock_asg.should_receive(:update).with(
        {:min_size => 1, :max_size => 3, :desired_capacity => 2, :launch_configuration => 'foobar'}
      )
      subject.update(
        {:min_size => 1, :max_size => 3, :desired_capacity => 2, 'launch_configuration' => 'foobar', :invalid => 'lalala'}
      )
    end
    it "should return the (valid) changes made" do
      subject.update(
        {:min_size => '1', 'desired_capacity' => 2, :launch_configuration => :foobar}
      ).should == {:min_size => 1, :desired_capacity => 2, :launch_configuration => 'foobar'}
    end
    it "should not update the auto scaling group if no valid changes are given" do
      mock_asg.should_not_receive(:update)
      subject.update.should == 'no changes to be made'
      subject.update({}).should == 'no changes to be made'
      subject.update({:invalid => 'foobar'}).should == 'no changes to be made'
    end
  end

end
