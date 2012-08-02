# encoding: utf-8
require 'yaml'

module MyfcCloud
  class Configuration
    attr_accessor :config

    def initialize(filepath)
      @config = YAML.load_file(filepath)
    end

  end
end
