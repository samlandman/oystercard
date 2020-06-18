require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance
  attr_accessor :journeys
  DEFAULT_LIMIT = 90
  MINIMUM = 1

  def initialize(limit = DEFAULT_LIMIT, min = MINIMUM)
    @balance = 0
    @limit = limit
    @min = min 
    @journeys = [Journey.new]
  end

  def top_up(value)
    return raise "Maximum limit is #{@limit}." if (@balance + value) > @limit
    @balance += value
  end

  def deduct(amount)
    @balance -= amount
  end
 
  def in_journey?
    @journeys == [] ? false : @journeys.last.in_journey?
  end

  def touch_in(station)
    fail "Not enough funds available. Min fund is #{@min}." if @balance < MINIMUM
    @journeys.last.start_journey(station)
  end

  def touch_out(station)
     deduct(MINIMUM)
     @journeys.last.end_journey(station)
     @journeys << Journey.new
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
