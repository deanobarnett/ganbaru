# frozen_string_literal: true
require 'test_helper'
require 'runners/rspec/result'

class TestRunnerRspecExecutor < Minitest::Test
  def setup
    @files = ["some_spec.rb"]
  end

  def result_hash(failed, count)
     %Q({"examples"=>["test"],"summary"=>{"failure_count"=>#{failed},"example_count"=>#{count}}})
  end

  def test_failed_when_failed_specs
    result = Runners::Rspec::Result.new(result_hash(1, 1), @files)
    assert(result.failed?)
  end

  def test_failed_when_errored_specs
    result = Runners::Rspec::Result.new(result_hash(0, 0), @files)
    assert(result.failed?)
  end

  def test_passed_when_no_failed_specs
    result = Runners::Rspec::Result.new(result_hash(0, 1), @files)
    assert(!result.failed?)
  end

  def test_empty_spec_file
    result = Runners::Rspec::Result.new('{"examples"=>[]}', @files)
    assert(!result.failed?)
  end

  def test_to_h
    result = Runners::Rspec::Result.new('{"summary"=>{"failure_count"=>0,"example_count"=>1}}', @files)
    assert_equal(result.to_h, 'summary' => {
                   'failure_count' => 0,
                   'example_count' => 1,
                 },
                 'files' => ['some_spec.rb']
                )
  end
end
