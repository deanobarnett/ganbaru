# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'ganbaru'
  spec.version       = '0.2.0'
  spec.authors       = ['Dean Barnett']
  spec.email         = ['dean@shopkeep.com']

  spec.summary       = 'Worker strategy for tests.'
  spec.description   = 'Fan out test runs and use Redis to co-ordinate.'
  spec.homepage      = 'https://github.com/shopkeep/'
  spec.license       = 'MIT'

  spec.files         = []
  spec.bindir        = 'bin'
  spec.executables   = ['ganbaru']
  spec.require_paths = ['lib']

  spec.add_dependency 'redis', '~> 3.2'
  spec.add_dependency 'rspec', '~> 3.5'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'progress_bar'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'dogstatsd-ruby'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'minitest', '~> 5.8.4'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'fakeredis', '~> 0.6.0'
end
