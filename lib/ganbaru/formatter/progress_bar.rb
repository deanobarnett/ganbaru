# frozen_string_literal: true

require 'progress_bar'

module Ganbaru
  module Formatter
    class ProgressBar
      def initialize(total)
        max = total.zero? ? 1 : total
        @bar = ::ProgressBar.new(max, :bar, :percentage, :eta)
      end

      def update(_name); end

      def add(value)
        @bar.increment!(value)
        @bar.write
      end

      def progress
        @bar.count
      end

      def remaining
        @bar.remaining
      end
    end
  end
end
