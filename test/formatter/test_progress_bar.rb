# frozen_string_literal: true

require 'test_helper'
require 'support/utils'
require 'ganbaru/formatter/progress_bar'

class TestGanbaru < Minitest::Test
  def test_it_tracks_with_a_progress_bar
    with_no_stderr do
      formatter = Ganbaru::Formatter::ProgressBar.new(50)
      formatter.add(10)
      assert_equal(formatter.progress, 10)
      assert_equal(formatter.remaining, 40)

      formatter.add(10)
      assert_equal(formatter.progress, 20)
      assert_equal(formatter.remaining, 30)
    end
  end
end
