
class Oystercard

  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @in_journey = false
    # @touch_in = travel
  end

  def top_up(value)
    return raise "Maximum limit is #{@limit}." if (@balance + value) > @limit
    @balance += value
  end

  def deduct(amount)
    @balance -= amount
  end
 
  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
     @in_journey = false
  end

end
