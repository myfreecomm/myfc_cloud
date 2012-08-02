# encoding: utf-8
require 'spec_helper'

describe MyfcCloud::Commands::ScalingGroup do
  let(:configuration) { MyfcCloud::Configuration.new(yaml_fixture_path('configuration_full')) }
  subject { described_class.new(configuration) }

  describe '#update' do
    let(:mock_asg) { mock('scaling_group').as_null_object }
    before(:each) do
      subject.stub(:check_existence!).and_return(true)
      subject.stub(:scaling_group).and_return(mock_asg)
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
