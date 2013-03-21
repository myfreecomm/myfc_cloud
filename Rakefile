# encoding: utf-8
require "bundler/gem_tasks"

require "rspec/core/rake_task"

require 'rdoc/task'

RSpec::Core::RakeTask.new(:spec)

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'myfc_cloud'
end

task :test => :spec
task :default => :spec
