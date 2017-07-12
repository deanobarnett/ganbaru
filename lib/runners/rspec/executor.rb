# frozen_string_literal: true
require 'rspec'
require 'runners/errors'
require 'runners/rspec/result'

module Runners
  module Rspec
    class Executor
      def initialize(rspec: RSpec, runner: RSpec::Core::Runner)
        @rspec = rspec
        @runner = runner
        @output = StringIO.new
      end

      # Run Rspec Test with JSON formatter
      def run(specs)
        err = StringIO.new
        @runner.run(['-f', 'j', specs], err, @output)
        process_result
      ensure
        @rspec.clear_examples
      end

      private

      def process_result
        result_class.tap do |result|
          raise Runners::FailedTestError, result if result.failed?
        end
      end

      def result_class
        result = @output.string
        @output.reopen
        return Runners::Rspec::NullResult.new if result.to_s.strip.empty?
        Runners::Rspec::Result.new(result)
      end
    end
  end
end
