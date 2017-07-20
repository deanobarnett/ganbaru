# frozen_string_literal: true

require 'statsd-instrument'

module Track
  module Metrics
    def self.worker(worker_id)
      tags = ["worker_id:#{worker_id}"]

      StatsD.prefix = "ganbaru.#{ENV['STATSD_NAMESPACE']}"

      Ganbaru::Worker.extend StatsD::Instrument
      Ganbaru::Worker.statsd_measure :run, 'worker.run.time', tags: tags

      Runners::Rspec::Executor.extend StatsD::Instrument
      Runners::Rspec::Executor.statsd_count_success :run, 'rspec.executor.run', tags: tags
    end
  end
end
