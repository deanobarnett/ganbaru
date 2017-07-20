# frozen_string_literal: true

class MessageQueue
  attr_reader :id

  def initialize(queue, id)
    @queue = queue
    @id = id
  end

  def destroy!
    @queue.ltrim(@id, -1, 0)
    @queue.del(@id)
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
