
class Oystercard

  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end

  def top_up(value)
    return raise "Maximum limit is #{@limit}." if (@balance + value) > @limit
    @balance += value

  end


end
