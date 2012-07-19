# encoding: utf-8
# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','myfc_cloud','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'myfc_cloud'
  s.version = MyfcCloud::VERSION
  s.authors = ['Rodrigo Tassinari de Oliveira']
  s.email = ['rodrigo.tassinari@myfreecomm.com.br', 'rodrigo@pittlandia.net']
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line application to deploy and manage webapps on Amazon Web Services'

  # Add your other files here if you make them
  s.files = %w(
bin/myfc_cloud
lib/myfc_cloud_version.rb
  )
  # s.files = `git ls-files`.split("\n")
  # s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','myfc_cloud.rdoc']
  s.rdoc_options << '--title' << 'myfc_cloud' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'

  s.executables << 'myfc_cloud'
  # s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')

  s.add_runtime_dependency('gli', '1.6.0')
  s.add_runtime_dependency('aws-sdk', '1.5.7')
end
