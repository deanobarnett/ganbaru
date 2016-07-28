# frozen_string_literal: true
require 'test_helper'
require 'support/utils'
require 'minitest/mock'
require 'runners/rspec'

class TestGanbaru < Minitest::Test
  def test_it_runs_and_clears
    runner = Minitest::Mock.new
    runner.expect(:run, true, ['foo'])

    rspec = Minitest::Mock.new
    rspec.expect(:clear_examples, nil)

    Runners::Rspec.run('foo', runner: runner, rspec: rspec)

    assert runner.verify
    assert rspec.verify
  end

  def test_when_there_is_an_error
    runner = Minitest::Mock.new

    runner.expect(:run, true) do
      raise StandardError
    end

    rspec = Minitest::Mock.new
    rspec.expect(:clear_examples, nil)

    with_no_stdout do
      Runners::Rspec.run('foo', runner: runner, rspec: rspec)
    end

    assert rspec.verify
  end
end
