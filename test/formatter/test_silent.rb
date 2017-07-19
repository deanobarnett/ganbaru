# frozen_string_literal: true

require 'test_helper'
require 'support/utils'
require 'ganbaru/formatter/silent'

class TestGanbaru < Minitest::Test
  def test_it_tracks_progress_silently
    with_no_stderr do
      formatter = Ganbaru::Formatter::Silent.new(50)
      formatter.add(10)
      assert_equal(10, formatter.progress)
      assert_equal(40, formatter.remaining)

      formatter.add(10)
      assert_equal(20,formatter.progress)
      assert_equal(30, formatter.remaining)
    end
  end
end
