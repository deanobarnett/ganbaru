# frozen_string_literal: true
require 'test_helper'
require 'message_queue'

class TestQueue < Minitest::Test
  class MockQueue
    def rpush(_id, _values)
      true
    end

    def lpop(_id)
      true
    end

    def llen(_id)
      10
    end
  end

  def test_push
    queue = MessageQueue.new(MockQueue.new, '123')
    assert(queue.push(['foo']))
  end

  def test_pop
    queue = MessageQueue.new(MockQueue.new, '123')
    assert(queue.pop)
  end

  def test_size
    queue = MessageQueue.new(MockQueue.new, '123')
    assert_equal(10, queue.size)
  end
end
