# frozen_string_literal: true
require 'redis_client'
require 'formatter/basic'
require 'runners/rspec'
require 'track/progress'

module Ganbaru
  class Worker
    def initialize(queue)
      @queue = queue
      @progress = Track::Progress.new(queue)
      @specs_run = []
    end

    def run(runner = Runners::Rspec)
      loop do
        spec = @queue.pop
        @progress.update
        break if spec.nil? || spec.empty?

        runner.run([spec])
        @specs_run << spec
      end

      @specs_run
    end
  end
end
