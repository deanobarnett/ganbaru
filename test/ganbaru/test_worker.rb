# frozen_string_literal: true
require 'test_helper'
require 'support/utils'
require 'ganbaru/worker'

class TestWorker < Minitest::Test
  class MockDuration
    def slowest; end
    def total; end
  end
  class MockRunner
    def run(_specs); end
    def duration
      MockDuration.new
    end
  end

  def setup
    @queue = MessageQueue.new(RedisClient.new, '456')
  end

  def teardown
    @queue.destroy!
  end

  def test_when_there_are_specs_in_redis
    @queue.push(%w(a b))
    worker = Ganbaru::Worker.new(queue: @queue, runner: MockRunner.new)
    result = nil

    with_no_output do
      result = worker.run.sort
    end

    assert_equal(%w(a b), result)
  end

  def test_when_there_are_no_specs_in_redis
    worker = Ganbaru::Worker.new(queue: @queue, runner: MockRunner.new)
    result = nil

    with_no_output do
      result = worker.run.sort
    end

    assert_equal([], result)
  end
end
