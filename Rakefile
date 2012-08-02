# encoding: utf-8
require "bundler/gem_tasks"
require "rspec/core/rake_task"

require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'myfc_cloud'
end

spec = eval(File.read('myfc_cloud.gemspec'))
Gem::PackageTask.new(spec) do |pkg|
end

task :default => :spec
task :test => :spec
