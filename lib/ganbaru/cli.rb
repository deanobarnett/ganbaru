# frozen_string_literal: true
require 'thor'

module Ganbaru
  class Cli < Thor
    desc 'leader DIR', 'Run Ganbaru in Leader Mode'
    option :id, required: true
    option :dir, default: 'spec'
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will load the specs that need run into the supplied Redis instance.
    LONGDESC

    def leader
      Ganbaru::Leader.new(options[:dir], options[:id]).run
    end

    desc 'worker', 'Run Ganbaru in Worker Mode'
    option :id, required: true
    long_desc <<-LONGDESC
      Run an instance of the Ganbaru test runner.
      This will grab and run specs from the queue.
    LONGDESC

    def worker
      Ganbaru::Worker.new(options[:id]).run
    end
  end
end
