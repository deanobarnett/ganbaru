# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ganbaru/version'

Gem::Specification.new do |spec|
  spec.name          = "ganbaru"
  spec.version       = Ganbaru::VERSION
  spec.authors       = ["Dean Barnett"]
  spec.email         = ["dean@shopkeep.com"]

  spec.summary       = %q{Worker strategy for tests.}
  spec.description   = %q{Fan out test runs and use SQS to co-ordiante.}
  spec.homepage      = "https://github.com/shopkeep/"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "celluloid"
  spec.add_dependency "fake_sqs"
  spec.add_dependency "aws-sdk", '~> 2'
  spec.add_dependency "rspec"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
