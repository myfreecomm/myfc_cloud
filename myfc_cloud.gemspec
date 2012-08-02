# encoding: utf-8

# this is magic line that ensures "../lib" is in the load path
$:.push File.expand_path("../lib", __FILE__)

# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','myfc_cloud','version.rb'])

spec = Gem::Specification.new do |s|
  s.name = 'myfc_cloud'
  s.version = MyfcCloud::VERSION
  s.authors = ['Rodrigo Tassinari de Oliveira']
  s.email = ['rodrigo.tassinari@myfreecomm.com.br', 'rodrigo@pittlandia.net']
  s.homepage = 'https://github.com/myfreecomm/myfc_cloud'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Command line application to deploy and manage webapps on Amazon Web Services'
  s.description = 'Command line application to deploy and manage webapps on Amazon Web Services'

  # Add your other files here if you make them
#   s.files = %w(
# bin/myfc_cloud
# lib/myfc_cloud_version.rb
#   )
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','myfc_cloud.rdoc']
  s.rdoc_options << '--title' << 'myfc_cloud' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'

  # s.executables << 'myfc_cloud'
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('rspec', '~> 2.11')
  s.add_development_dependency('pry', '~> 0.9')
  s.add_development_dependency('pry-nav', '~> 0.2')
  s.add_development_dependency('pry-doc', '~> 0.4')
  s.add_development_dependency('pry-remote', '~> 0.1')
  s.add_development_dependency('awesome_print', '~> 1.0')

  s.add_runtime_dependency('gli', '~> 1.6')
  s.add_runtime_dependency('aws-sdk', '~> 1.6')
end
