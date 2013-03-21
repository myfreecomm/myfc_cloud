# encoding: utf-8
require "bundler/gem_tasks"

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  rdoc.title = 'myfc_cloud'
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = 'doc'
  rdoc.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  # rdoc.generator = 'darkfish'
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

task :test => :spec
task :default => :spec
