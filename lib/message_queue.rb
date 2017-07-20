# frozen_string_literal: true

class MessageQueue
  attr_reader :id

  def initialize(queue, id)
    @queue = queue
    @id = id
  end

  def push(values)
    @queue.rpush(@id, values)
  end

  def pop
    @queue.rpoplpush(@id, "temp-#{@id}")
  end

  def size
    @queue.llen(@id)
  end
end
