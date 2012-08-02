# encoding: utf-8
require 'spec_helper'

describe MyfcCloud::Configuration do

  let(:config_file_path) { yaml_fixture_path('configuration_full') }

  describe ".new" do
    it "should load the config from the Yaml file given it's path and default environment" do
      configuration = nil
      expect {
        configuration = described_class.new(config_file_path) # default to sandbox environment
      }.not_to raise_error

      configuration.config.instance_variable_get(:@table).should == {
        :access_key_id => 'SANDBOX_ACCESS_KEY_ID',
        :secret_access_key => 'SANDBOX_SECRET_ACCESS_KEY',
        :auto_scaling_group_name => 'sandbox_asg',
        :elastic_load_balancer_name => 'sandbox_elb',
        :rds_instance_identifier => 'sandbox_rds',
        :app_path_on_server => '/path/to/sandbox/app/src',
      }
    end
    it "should load the config from the Yaml file given it's path and environment" do
      configuration = nil
      expect {
        configuration = described_class.new(config_file_path, :production)
      }.not_to raise_error

      configuration.config.instance_variable_get(:@table).should == {
        :access_key_id => 'PRODUCTION_ACCESS_KEY_ID',
        :secret_access_key => 'PRODUCTION_SECRET_ACCESS_KEY',
        :auto_scaling_group_name => 'production_asg',
        :elastic_load_balancer_name => 'production_elb',
        :rds_instance_identifier => 'production_rds',
        :app_path_on_server => '/path/to/production/app/src',
      }
    end
    it "should raise an error if the environment is not found" do
      expect {
        configuration = described_class.new(config_file_path, :missing_environment)
      }.to raise_error(ArgumentError, "environment 'missing_environment' does not exist on '#{config_file_path}'")
    end
    context "getting the keys from the environment" do
      let(:config_file_path) { yaml_fixture_path('configuration_without_keys') }
      before(:each) do
        ENV['MYFC_CLOUD_ACCESS_KEY_ID'] = 'ENV_ACCESS_KEY_ID'
        ENV['MYFC_CLOUD_SECRET_ACCESS_KEY'] = 'ENV_SECRET_ACCESS_KEY'
      end
      it "should load the access_key_id from the local environment variables if missing from the config_file" do
        configuration = described_class.new(config_file_path, :sandbox)
        configuration.should respond_to(:access_key_id)
        configuration.access_key_id.should == 'ENV_ACCESS_KEY_ID'

        configuration = described_class.new(config_file_path, :production)
        configuration.should respond_to(:access_key_id)
        configuration.access_key_id.should == 'ENV_ACCESS_KEY_ID'

        configuration = described_class.new(config_file_path, :stage)
        configuration.should respond_to(:access_key_id)
        configuration.access_key_id.should == 'STAGE_ACCESS_KEY_ID'
      end
      it "should load the secret_access_key from the local environment variables if missing from the config_file" do
        configuration = described_class.new(config_file_path, :sandbox)
        configuration.should respond_to(:secret_access_key)
        configuration.secret_access_key.should == 'ENV_SECRET_ACCESS_KEY'

        configuration = described_class.new(config_file_path, :production)
        configuration.should respond_to(:secret_access_key)
        configuration.secret_access_key.should == 'ENV_SECRET_ACCESS_KEY'

        configuration = described_class.new(config_file_path, :stage)
        configuration.should respond_to(:secret_access_key)
        configuration.secret_access_key.should == 'ENV_SECRET_ACCESS_KEY'
      end
    end
  end

  context "settings" do
    subject { described_class.new(config_file_path) }
    it "should return the access_key_id" do
      subject.should respond_to(:access_key_id)
      subject.access_key_id.should == 'SANDBOX_ACCESS_KEY_ID'
    end
    it "should return the secret_access_key" do
      subject.should respond_to(:secret_access_key)
      subject.secret_access_key.should == 'SANDBOX_SECRET_ACCESS_KEY'
    end
    it "should return the auto_scaling_group_name" do
      subject.should respond_to(:auto_scaling_group_name)
      subject.auto_scaling_group_name.should == 'sandbox_asg'
    end
    it "should return the elastic_load_balancer_name" do
      subject.should respond_to(:elastic_load_balancer_name)
      subject.elastic_load_balancer_name.should == 'sandbox_elb'
    end
    it "should return the rds_instance_identifier" do
      subject.should respond_to(:rds_instance_identifier)
      subject.rds_instance_identifier.should == 'sandbox_rds'
    end
    it "should return the app_path_on_server" do
      subject.should respond_to(:app_path_on_server)
      subject.app_path_on_server.should == '/path/to/sandbox/app/src'
    end
  end

end
