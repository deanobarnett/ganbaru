module Track
  class Duration
    def initialize
      @examples = []
    end

    def add(example)
      @examples.concat(example)
      self
    end

    def total
      @examples.inject(0.0) do |memo, example|
        memo += example['run_time'].to_f
        memo.round(5)
      end
    end

    def slowest(amount = 10)
      @examples.sort_by do |example|
         -example['run_time'].to_f
       end.take(amount)
    end
  end
end
