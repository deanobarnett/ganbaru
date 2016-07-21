# frozen_string_literal: true
require 'rspec'

module Runners
  class Rspec
    def self.run(specs, runner: RSpec::Core::Runner, rspec: RSpec)
      runner.run(specs)
      rspec.clear_examples
    end
  end
end
