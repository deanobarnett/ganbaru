# frozen_string_literal: true
require 'test_helper'
require 'support/utils'
require 'minitest/mock'
require 'runners/rspec/executor'

class TestRunnerRspecExecutor < Minitest::Test
  def test_it_runs_and_clears
    rspec = Minitest::Mock.new
    rspec.expect(:clear_examples, nil)
    runner = Minitest::Mock.new
    runner.expect(:run, nil, [Array, StringIO, StringIO])

    result = Runners::Rspec::Executor.new(rspec: rspec, runner: runner).run('foo')
    # assert_mock(rspec)
  end

  # def test_when_there_is_an_error
  #   runner = Minitest::Mock.new
  #
  #   runner.expect(:run, true) do
  #     raise StandardError
  #   end
  #
  #   rspec = Minitest::Mock.new
  #   rspec.expect(:clear_examples, nil)
  #
  #   with_no_stdout do
  #     Runners::Rspec.run('foo', runner: runner, rspec: rspec)
  #   end
  #
  #   assert rspec.verify
  # end
end
