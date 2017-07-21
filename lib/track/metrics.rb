# frozen_string_literal: true

require 'forwardable'
require 'datadog/statsd'

module Track
  module Metrics
    extend SingleForwardable

    class Stats < Datadog::Statsd
      def initialize(run_id)
        namespace = "ganbaru.#{ENV['STATSD_NAMESPACE']}"
        tags = ["run_id:#{run_id}"]

        super(ENV['STATSD_HOST'],
              ENV['STATSD_PORT'].to_i,
              opts = { namespace: namespace, tags: tags })
      end
    end

    @stats = Stats.new(ENV['ID'])

    def_delegators :@stats, :increment
    def_delegators :@stats, :time
    def_delegators :@stats, :event
    def_delegators :@stats, :histogram
  end
end
