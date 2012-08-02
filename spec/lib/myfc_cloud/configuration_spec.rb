# encoding: utf-8
require 'spec_helper'

describe MyfcCloud::Configuration do

  describe ".new" do
    let(:config_file_path) { yaml_fixture_path('configuration') }
    it "should load the config from the Yaml file given it's path" do
      configuration = nil
      expect {
        configuration = described_class.new(config_file_path)
      }.not_to raise_error

      configuration.config.should == {
        'production' => {
          'foo' => 'bar',
          'arr' => [1, :two, 'three', 4.0],
          'nulo' => nil
        },
        'sandbox' => {
          'spam' => 'eggs',
          'arr' => []
        }
      }
    end
  end

end
