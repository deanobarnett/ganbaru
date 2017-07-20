# frozen_string_literal: true

require 'pp'
require 'runners/rspec/executor'
require 'runners/errors'
require 'track/progress'

module Ganbaru
  class Worker
    def initialize(queue:,
                   runner: Runners::Rspec::Executor.new,
                   formatter: 'silent')
      @queue = queue
      @runner = runner
      @progress = Track::Progress.new(queue: queue, formatter: formatter)
      @specs_run = []
    end

    def run
      loop do
        break unless spec = run_spec
        @specs_run << spec
      end

      @queue.destroy!
      @specs_run
    end

    def run_spec
      @queue.pop.tap do |spec|
        @progress.update
        return if spec.nil? || spec.empty?
        @runner.run([spec])
      end
    rescue Runners::FailedTestError => e
      pp(e.result.to_h)
      @queue.destroy!
      exit 2
    end
  end
end
