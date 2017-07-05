# frozen_string_literal: true
class Queue
  def initialize(redis, ref_id)
    @redis = redis
    @ref_id = ref_id
  end
end
