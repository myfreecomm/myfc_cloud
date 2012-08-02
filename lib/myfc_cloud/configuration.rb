# encoding: utf-8
require 'yaml'
require 'ostruct'

module MyfcCloud
  class Configuration
    attr_accessor :config

    def initialize(filepath, environment=:sandbox)
      config = YAML.load_file(filepath)
      raise ArgumentError, "environment '#{environment}' does not exist on '#{filepath}'" unless config.keys.include?(environment.to_s)
      @config_keys = config[environment.to_s].keys
      @config = OpenStruct.new(config[environment.to_s])
    end

    def access_key_id
      if !has_file_access_key_id? && has_env_access_key_id?
        ENV['MYFC_CLOUD_ACCESS_KEY_ID']
      else
        self.config.access_key_id
      end
    end

    def secret_access_key
      if !has_file_secret_access_key? && has_env_secret_access_key?
        ENV['MYFC_CLOUD_SECRET_ACCESS_KEY']
      else
        self.config.secret_access_key
      end
    end

    def method_missing(name, *args)
      if @config_keys.include?(name.to_s)
        self.config.send(name.to_s)
      else
        super
      end
    end

    def respond_to?(name)
      return true if @config_keys.include?(name.to_s)
      super
    end

    private

    def has_file_access_key_id?
      !self.config.access_key_id.nil? && self.config.access_key_id.to_s.strip != ''
    end

    def has_file_secret_access_key?
      !self.config.secret_access_key.nil? && self.config.secret_access_key.to_s.strip != ''
    end

    def has_env_access_key_id?
      !ENV['MYFC_CLOUD_ACCESS_KEY_ID'].nil? && ENV['MYFC_CLOUD_ACCESS_KEY_ID'].strip != ''
    end

    def has_env_secret_access_key?
      !ENV['MYFC_CLOUD_SECRET_ACCESS_KEY'].nil? && ENV['MYFC_CLOUD_SECRET_ACCESS_KEY'].strip != ''
    end

  end
end
