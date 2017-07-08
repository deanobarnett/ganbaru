# frozen_string_literal: true
require 'test_helper'
require 'ganbaru'
require_relative 'support/fake_queue'
require_relative 'support/utils'

class TestGanbaru < Minitest::Test
  def setup
    @queue = FakeQueue.new('123')
  end

  def test_loading_and_running
    specs_actually_run = nil
    specs_to_run = nil

    with_no_output do
      specs_to_run = Ganbaru::Leader.new(@queue).run('spec/examples')
      specs_actually_run = Ganbaru::Worker.new(@queue).run
    end

    assert_equal(specs_to_run, specs_actually_run.size)
  end
end
