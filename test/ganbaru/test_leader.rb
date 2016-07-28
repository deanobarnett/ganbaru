# frozen_string_literal: true
require 'test_helper'
require 'support/utils'
require 'ganbaru/leader'
require_relative '../support/fake_redis'

class TestWorker < Minitest::Test
  def setup
    @redis = FakeRedis.new
  end

  def test_when_there_are_specs
    leader = Ganbaru::Leader.new('spec', redis: @redis)
    result = nil

    with_no_stdout do
      result = leader.run
    end

    assert_equal(4, result)
  end

  def test_when_there_are_no_specs
    leader = Ganbaru::Leader.new('totally_fake', 'fake id', redis: @redis)
    result = nil

    with_no_stdout do
      result = leader.run
    end

    assert_equal(0, result)
  end

  def test_when_ref_id_is_set
    leader = Ganbaru::Leader.new('totally_fake', 'fake id', redis: @redis)

    assert_equal('fake id', leader.ref_id)
  end
end
