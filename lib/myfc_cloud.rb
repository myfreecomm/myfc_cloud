# encoding: utf-8
require 'aws'

require "myfc_cloud/commands"
require "myfc_cloud/configuration"
require "myfc_cloud/version"

module MyfcCloud
end

# TODO extract these extensions to separate file (or just use active_support already)
class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

class Hash
  def symbolize_keys
    inject({}) do |options, (key, value)|
      options[(key.to_sym rescue key) || key] = value
      options
    end
  end

  def symbolize_keys!
    self.replace(self.symbolize_keys)
  end
end
