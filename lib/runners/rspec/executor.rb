# frozen_string_literal: true
require 'rspec'
require 'track/duration'
require 'runners/errors'
require 'runners/null_result'
require 'runners/rspec/result'
require 'track/metrics'

module Runners
  module Rspec
    class Executor
      attr_reader :duration

      def initialize(rspec: RSpec, runner: RSpec::Core::Runner)
        @rspec = rspec
        @runner = runner
        @output = StringIO.new
        @duration = Track::Duration.new
      end

      # Run Rspec Test with JSON formatter
      def run(specs)
        err = StringIO.new

        Track::Metrics.time('spec.run.time', tags: ["names:#{specs.join('-')}"]) do
          @runner.run(['-f', 'j', specs], err, @output)
        end

        process_result(specs)
        Track::Metrics.increment('rspec.executor.run.success')
      rescue Runners::FailedTestError => e
        Track::Metrics.increment('rspec.executor.run.fail')
        raise
      ensure
        @rspec.clear_examples
      end

      private

      def process_result(specs)
        result_class(specs).tap do |result|
          @duration.add(result.examples)
          raise Runners::FailedTestError, result if result.failed?
        end
      end

      def result_class(specs)
        result = @output.string
        @output.reopen
        return Runners::NullResult.new if result.to_s.strip.empty?
        Runners::Rspec::Result.new(result, specs)
      end
    end
  end
end
