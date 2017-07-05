# frozen_string_literal: true
require 'progress_bar'

module Formatter
  class Basic
    def initialize(total)
      @bar = ProgressBar.new(total, :bar, :percentage, :eta)
    end

    def increment(value)
      @bar.increment!(value)
    end

    def progress
      @bar.count
    end

    def remaining
      @bar.remaining
    end
  end
end
