# frozen_string_literal: true
module Runners
  class FailedTestError < StandardError
    attr_reader :result

    def initialize(result)
      super result.to_h
      @result = result
    end
  end
end
