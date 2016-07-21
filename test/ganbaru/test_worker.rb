# frozen_string_literal: true
require 'test_helper'
require 'ganbaru/worker'
require_relative '../support/fake_redis'

class TestWorker < Minitest::Test
  class MockRunner
    def self.run(_specs); end
  end

  def setup
    @redis = FakeRedis.new
  end

  def test_when_there_are_specs_in_redis
    ref_id = 'foo'
    @redis.rpush(ref_id, %w(a b))
    worker = Ganbaru::Worker.new(ref_id, redis: @redis)

    result = worker.run(MockRunner).sort

    assert_equal(%w(a b), result)
  end

  def test_when_there_are_no_specs_in_redis
    ref_id = 'foo'
    worker = Ganbaru::Worker.new(ref_id, redis: @redis)

    result = worker.run(MockRunner).sort

    assert_equal([], result)
  end
end
