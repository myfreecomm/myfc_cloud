# encoding: utf-8

require 'aws'

require File.join(File.dirname(__FILE__), "myfc_cloud/version")
require File.join(File.dirname(__FILE__), "myfc_cloud/configuration")
require File.join(File.dirname(__FILE__), "myfc_cloud/commands")

module MyfcCloud

end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end
