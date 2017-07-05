# frozen_string_literal: true

require 'test_helper'
require 'support/utils'
require 'formatter/basic'

class TestGanbaru < Minitest::Test
  def test_it_tracks_progress
    with_no_stderr do
      formatter = Formatter::Basic.new(50)
      formatter.increment(10)
      assert_equal(formatter.progress, 10)
      assert_equal(formatter.remaining, 40)

      formatter.increment(10)
      assert_equal(formatter.progress, 20)
      assert_equal(formatter.remaining, 30)
    end
  end
end
