# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'ganbaru'
  spec.version       = '0.1.0'
  spec.authors       = ['Dean Barnett']
  spec.email         = ['dean@shopkeep.com']

  spec.summary       = 'Worker strategy for tests.'
  spec.description   = 'Fan out test runs and use Redis to co-ordiante.'
  spec.homepage      = 'https://github.com/shopkeep/'
  spec.license       = 'MIT'

  spec.files         = []
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| f[3..-1] }
  spec.require_paths = ['lib']

  spec.add_dependency 'redis', '~> 3.2'
  spec.add_dependency 'rspec'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
