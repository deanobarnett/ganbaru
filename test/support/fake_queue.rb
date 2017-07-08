# frozen_string_literal: true
class FakeQueue
  def initialize(key)
    @key = key
    @values = {}
  end

  def push(values)
    @values[@key] = [] unless @values.key?(@key)
    @values[@key].concat(values)
    size
  end

  def pop
    return unless @values.key?(@key)
    @values[@key].pop
  end

  def size
    return 0 unless @values.key?(@key)
    @values[@key].size
  end
end
