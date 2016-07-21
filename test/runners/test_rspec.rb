require 'test_helper'
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
end
