# encoding: utf-8

def yaml_fixture_path(name)
  File.join(File.dirname(__FILE__), "../fixtures/#{name}.yml")
end
