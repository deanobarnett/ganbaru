# frozen_string_literal: true
require 'test_helper'
require 'ganbaru'
require_relative 'support/utils'

class TestGanbaru < Minitest::Test
  def test_loading_and_running
    specs_actually_run = nil
    specs_to_run = nil

    with_no_output do
      queue =  MessageQueue.new(RedisClient.new, 'id')
      specs_to_run = Ganbaru::Leader.new(queue: queue).run('spec/examples')
      specs_actually_run = Ganbaru::Worker.new(queue: queue).run
    end

    assert_equal(specs_to_run, specs_actually_run.size)
  end
end
