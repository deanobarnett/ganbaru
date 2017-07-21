# frozen_string_literal: true
require 'test_helper'
require 'track/duration'

class TestTrackDuration < Minitest::Test
  def test_successful_examples
    examples = [{ 'run_time'=>0.1 }, { 'run_time'=>0.2 }]
    total_duration = Track::Duration.new.add(examples).total
    assert_equal(0.3, total_duration)
  end

  def test_empty_examples
    total_duration = Track::Duration.new.add([]).total
    assert_equal(0.0, total_duration)
  end

  def test_missing_run_time
    total_duration = Track::Duration.new.add([{}]).total
    assert_equal(0.0, total_duration)
  end

  def test_slowest
    examples = [{'run_time'=>0.1}, {'run_time'=>0.2}]
    slowest = Track::Duration.new.add(examples).slowest(1)
    assert_equal([{'run_time'=>0.2}], slowest)
  end

  def test_slowest_default_amount
    examples = [
      {'run_time'=>0.1},
      {'run_time'=>0.2},
      {'run_time'=>0.1},
      {'run_time'=>0.2},
      {'run_time'=>0.001},
      {'run_time'=>0.002},
      {'run_time'=>0.1},
      {'run_time'=>0.2},
      {'run_time'=>0.1},
      {'run_time'=>0.2},
      {'run_time'=>0.1},
      {'run_time'=>0.2}
    ]
    expected = [
      {'run_time'=>0.2},
      {'run_time'=>0.2},
      {'run_time'=>0.2},
      {'run_time'=>0.2},
      {'run_time'=>0.2},
      {'run_time'=>0.1},
      {'run_time'=>0.1},
      {'run_time'=>0.1},
      {'run_time'=>0.1},
      {'run_time'=>0.1}
    ]
    slowest = Track::Duration.new.add(examples).slowest
    assert_equal(expected, slowest)
  end
end
