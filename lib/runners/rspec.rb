# frozen_string_literal: true
require 'rspec'

module Runners
  class Rspec
    def self.run(specs)
      RSpec::Core::Runner.run(specs)
      RSpec.clear_examples
    end
  end
end
