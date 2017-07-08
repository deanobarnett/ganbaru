# frozen_string_literal: true
require 'progress_bar'

module Formatter
  class Basic
    def initialize(total)
      max = total.zero? ? 1 : total
      @bar = ProgressBar.new(max, :bar, :percentage, :eta)
    end

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
