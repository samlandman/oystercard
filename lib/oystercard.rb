
class Oystercard

  attr_reader :balance, :entry_station
  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MIN_CHARGE = 1

  def initialize(limit = DEFAULT_LIMIT, min = MINIMUM)
    @balance = 0
    @limit = limit
    @in_journey = false
    @min = min  
  end

  def top_up(value)
    return raise "Maximum limit is #{@limit}." if (@balance + value) > @limit
    @balance += value
  end

  def deduct(amount)
    @balance -= amount
  end
 
  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Not enough funds available. Min fund is #{@min}." if @balance < MINIMUM
    @in_journey = true
    @entry_station = station
  end

  def touch_out
     deduct(MIN_CHARGE)
     @in_journey = false
     @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
