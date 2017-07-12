# frozen_string_literal: true
require 'test_helper'
require 'support/utils'
require 'ganbaru/worker'
require_relative '../support/fake_queue'

class TestWorker < Minitest::Test
  class MockRunner
    def self.run(_specs); end
  end

  def setup
    @queue = FakeQueue.new('foo')
  end

  def test_when_there_are_specs_in_redis
    @queue.push(%w(a b))
    worker = Ganbaru::Worker.new(@queue, runner: MockRunner)
    result = nil

    with_no_output do
      result = worker.run.sort
    end

    assert_equal(%w(a b), result)
  end

  def test_when_there_are_no_specs_in_redis
    worker = Ganbaru::Worker.new(@queue, runner: MockRunner)
    result = nil

    with_no_output do
      result = worker.run.sort
    end

    assert_equal([], result)
  end
end
