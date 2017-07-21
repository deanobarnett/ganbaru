module Runners
  class NullResult
    def failed?
      false
    end

    def examples
      []
    end

    def to_h
      {}
    end
  end
end
