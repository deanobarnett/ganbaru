# frozen_string_literal: true
require 'minitest/autorun'
require 'ganbaru'

def silent_spec
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout = old_stdout
end

class FakeRedis
  def initialize(*_args)
    @values = {}
  end

  def rpush(key, values)
    @values[key] = [] unless @values.key?(key)
    @values[key].concat(values)
    @values[key].size
  end

  def lpop(key)
    return unless @values.key?(key)
    @values[key].pop
  end
end

class TestGanbaru < Minitest::Test
  def setup
    @redis = FakeRedis.new
  end

  def test_loading_and_running
    leader = Ganbaru::Leader.new('spec/examples', redis: @redis)
    worker = Ganbaru::Worker.new(leader.ref_id, redis: @redis)

    specs_to_run = leader.run
    specs_actually_run = nil

    silent_spec do
      specs_actually_run = worker.run
    end

    assert_equal(specs_to_run, specs_actually_run.size)
  end
end
