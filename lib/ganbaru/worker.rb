# frozen_string_literal: true
require 'redis_client'
require 'runners/rspec'

module Ganbaru
  class Worker
    def initialize(ref_id, redis: nil)
      @redis = redis || RedisClient.new
      @ref_id = ref_id
      @specs_run = []
    end

    def run(runner = Runners::Rspec)
      loop do
        spec = @redis.lpop(@ref_id)
        break if spec.nil? || spec.empty?
        puts "Running #{spec}"
        runner.run([spec])
        @specs_run << spec
      end

      @specs_run.tap do
        @specs_run.size
      end
    end
  end
end
