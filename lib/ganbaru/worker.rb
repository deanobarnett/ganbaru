# frozen_string_literal: true
require 'redis_client'
require 'formatter/basic'
require 'runners/rspec'
require 'track/progress'

module Ganbaru
  class Worker
    def initialize(ref_id, redis: nil)
      @redis = redis || RedisClient.new
      @ref_id = ref_id
      @specs_run = []
      @progress = Track::Progress.new(redis, ref_id)
    end

    def run(runner = Runners::Rspec)
      loop do
        spec = @redis.lpop(@ref_id)
        break if spec.nil? || spec.empty?
        runner.run([spec])
        @specs_run << spec
        @progress.update
      end

      @specs_run
    end
  end
end
