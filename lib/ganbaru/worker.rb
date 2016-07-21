# frozen_string_literal: true
require 'redis_client'
require 'rspec'

module Ganbaru
  class Worker
    def initialize(ref_id, redis: nil)
      @redis = redis || RedisClient.new
      @ref_id = ref_id
      @specs_run = []
    end

    def run
      loop do
        spec = @redis.lpop(@ref_id)
        break if spec.nil? || spec.empty?
        RSpec::Core::Runner.run([spec])
        RSpec.clear_examples
        @specs_run << spec
      end

      @specs_run
    end
  end
end
