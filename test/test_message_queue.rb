# frozen_string_literal: true

require 'test_helper'
require 'message_queue'

class TestQueue < Minitest::Test
  def redis
    RedisClient.new
  end

  def id
    '123'
  end

  def setup
    @queue = MessageQueue.new(redis, id)
  end

  def teardown
    @queue.destroy!
  end

  def test_push
    assert_equal(0, @queue.size)
    assert(@queue.push(['foo']))
    assert_equal(1, @queue.size)
  end

  def test_pop
    @queue.push(['foo'])
    assert_equal(1, @queue.size)
    assert(@queue.pop)
    assert_equal(0, @queue.size)
  end

  def test_size
    assert_equal(0, @queue.size)
    @queue.push(['foo'])
    assert_equal(1, @queue.size)
  end

  def test_destroy!
    assert(@queue.push(['foo', 'bar']))
    assert_equal(2, @queue.size)
    @queue.destroy!
    assert_equal(0, @queue.size)
    @queue.destroy!
    assert_equal(0, @queue.size)
  end
end
