# frozen_string_literal: true
require 'test_helper'
require 'ganbaru/leader'
require_relative '../support/fake_redis'

class TestWorker < Minitest::Test
  def setup
    @redis = FakeRedis.new
  end

  def test_when_there_are_specs
    leader = Ganbaru::Leader.new('spec', redis: @redis)
    result = leader.run

    assert_equal(4, result)
  end

  def test_when_there_are_no_specs
    leader = Ganbaru::Leader.new('totally_fake', redis: @redis)
    result = leader.run

    assert_equal(0, result)
  end

  def test_when_build_id_is_set
    ENV['BUILD_ID'] = 'fake id'
    leader = Ganbaru::Leader.new('totally_fake', redis: @redis)

    result = leader.ref_id

    assert_equal('fake id', result)
  end
end
