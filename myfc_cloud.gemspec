# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','myfc_cloud','version.rb'])

Gem::Specification.new do |spec|
  spec.name        = 'myfc_cloud'
  spec.version     = MyfcCloud::VERSION
  spec.authors     = ['Rodrigo Tassinari de Oliveira']
  spec.email       = ['rodrigo.tassinari@myfreecomm.com.br', 'rodrigo@pittlandia.net']
  spec.homepage    = 'https://github.com/myfreecomm/myfc_cloud'
  spec.platform    = Gem::Platform::RUBY
  spec.summary     = 'Command line application to deploy and manage webapps on Amazon Web Services'
  spec.description = 'Command line application to deploy and manage webapps on Amazon Web Services'
  spec.license     = "Apache-v2"
  spec.has_rdoc    = true
  spec.extra_rdoc_files = ['README.rdoc']
  spec.rdoc_options << '--title' << 'myfc_cloud' << '--main' << 'README.rdoc' << '-ri'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.bindir = 'bin'

  spec.add_dependency 'gli', '~> 2.5.5'
  spec.add_dependency 'aws-sdk', '~> 1.8.5'
  spec.add_dependency 'awesome_print', '~> 1.1.0'

  spec.add_development_dependency 'bundler', '~> 1.3.2'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'rdoc', '~> 4.0.0'
  spec.add_development_dependency 'rspec', '~> 2.13.0'
  # spec.add_development_dependency 'vcr', '~> 2.4.0'
  # spec.add_development_dependency 'webmock', '~> 1.9.3'
  spec.add_development_dependency 'pry', '~> 0.9.12'
  spec.add_development_dependency 'pry-nav', '~> 0.2.3'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'coveralls', '~> 0.6.3'
end
