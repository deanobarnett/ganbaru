# frozen_string_literal: true
class FakeRedis
  def initialize(*_args)
    @values = {}
  end

  def rpush(key, values)
    @values[key] = [] unless @values.key?(key)
    @values[key].concat(values)
    @values[key].size
  end

  def lpop(key)
    return unless @values.key?(key)
    @values[key].pop
  end

  def lrange(id, *args)
    @values
  end
end
