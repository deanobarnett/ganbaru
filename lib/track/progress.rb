# frozen_string_literal: true
module Track
  class Progress
    attr_reader :remaining

    def initialize(redis, ref_id)
      @redis = redis
      @ref_id = ref_id
      @remaining = redis.llen(ref_id)
      @formatter = Formatter::Basic.new(@remaining)
    end

    def update
      new_remaining = @redis.llen(@ref_id)
      @formatter.increment(@remaining - new_remaining)
      @remaining = new_remaining
    end
  end
end
