# frozen_string_literal: true
require 'test_helper'
require 'runners/rspec/result'

class TestRunnerRspecExecutor < Minitest::Test
  def test_failed_when_failed_specs
    result = Runners::Rspec::Result.new('{"summary"=>{"failure_count"=>1,"example_count"=>1}}')
    assert(result.failed?)
  end

  def test_failed_when_errored_specs
    result = Runners::Rspec::Result.new('{"summary"=>{"failure_count"=>0,"example_count"=>0}}')
    assert(result.failed?)
  end

  def test_passed_when_no_failed_specs
    result = Runners::Rspec::Result.new('{"summary"=>{"failure_count"=>0,"example_count"=>1}}')
    assert(!result.failed?)
  end

  def test_to_h
    result = Runners::Rspec::Result.new('{"summary"=>{"failure_count"=>0,"example_count"=>1}}')
    assert_equal(result.to_h, 'summary' => {
                   'failure_count' => 0,
                   'example_count' => 1,
                 })
  end
end
