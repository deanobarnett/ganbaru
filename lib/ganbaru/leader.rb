# frozen_string_literal: true
require 'redis_client'

module Ganbaru
  class Leader
    attr_reader :ref_id

    def initialize(dir, ref_id, redis: nil)
      @redis = redis || RedisClient.new
      @ref_id = ref_id
      @dir = dir
    end

    def run
      @redis.rpush(@ref_id, spec_files)
    end

    def show_specs_left
      @redis.lrange(@ref_id, 0, -1)
    end

    private

    def spec_files
      Dir.glob("#{@dir}/**/*_spec.rb")
    end
  end
end
