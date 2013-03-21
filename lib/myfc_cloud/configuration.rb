# encoding: utf-8
require 'yaml'
require 'ostruct'

module MyfcCloud # :nodoc:
  class Configuration

    def initialize(filepath, environment=:sandbox)
      config = YAML.load_file(filepath)
      raise ArgumentError, "environment '#{environment}' does not exist on '#{filepath}'" unless config.keys.include?(environment.to_s)
      @config_keys = config[environment.to_s].keys
      @config = OpenStruct.new(config[environment.to_s])
    end

    def access_key_id
      if @config.access_key_id.blank? && !ENV['MYFC_CLOUD_ACCESS_KEY_ID'].blank?
        ENV['MYFC_CLOUD_ACCESS_KEY_ID']
      else
        @config.access_key_id
      end
    end

    def secret_access_key
      if @config.secret_access_key.blank? && !ENV['MYFC_CLOUD_SECRET_ACCESS_KEY'].blank?
        ENV['MYFC_CLOUD_SECRET_ACCESS_KEY']
      else
        @config.secret_access_key
      end
    end

    def method_missing(name, *args)
      if @config_keys.include?(name.to_s)
        @config.send(name.to_s)
      else
        super
      end
    end

    def respond_to?(name)
      return true if @config_keys.include?(name.to_s)
      super
    end

  end
end
