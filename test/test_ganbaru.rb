# frozen_string_literal: true
require 'test_helper'
require 'ganbaru'
require_relative 'support/fake_redis'
require_relative 'support/utils'

class TestGanbaru < Minitest::Test
  def setup
    @redis = FakeRedis.new
  end

  def test_loading_and_running
    leader = Ganbaru::Leader.new('spec/examples', redis: @redis)
    worker = Ganbaru::Worker.new(leader.ref_id, redis: @redis)

    specs_to_run = leader.run
    specs_actually_run = nil

    with_no_stdout do
      specs_actually_run = worker.run
    end

    assert_equal(specs_to_run, specs_actually_run.size)
  end
end
