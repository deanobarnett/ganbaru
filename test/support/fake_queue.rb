# frozen_string_literal: true
class FakeQueue
  attr_reader :id

  def initialize(id)
    @id = id
    @values = {}
  end

  def push(values)
    @values[@id] = [] unless @values.key?(@id)
    @values[@id].concat(values)
    size
  end

  def pop
    return unless @values.key?(@id)
    @values[@id].pop
  end

  def size
    return 0 unless @values.key?(@id)
    @values[@id].size
  end
end
