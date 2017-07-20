# frozen_string_literal: true

require 'test_helper'
require 'support/utils'
require 'ganbaru/leader'

class TestWorker < Minitest::Test
  def setup
    @queue = MessageQueue.new(RedisClient.new, 'fake_id')
  end

  def teardown
    @queue.destroy!
  end

  def test_when_there_are_specs
    leader = Ganbaru::Leader.new(queue: @queue)
    result = nil

    with_no_stdout do
      result = leader.run('spec')
    end

    assert_equal(4, result)
  end


  def test_when_there_are_no_specs
    leader = Ganbaru::Leader.new(queue: @queue)
    result = nil

    with_no_stdout do
      result = leader.run('fake_dir')
    end

    assert_equal(0, result)
  end
end
