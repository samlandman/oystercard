require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance
  attr_accessor :journeys
  DEFAULT_LIMIT = 90

  def initialize(limit = DEFAULT_LIMIT, min = Journey::MINIMUM_FARE)
    @balance = 0
    @limit = limit
    @min = min 
    #@journeys = [Journey.new]
    @journeys = Journeylog.new.journeys 
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
    #@journeylog == [] ? false : @journeylog.last.in_journey?
  end

  def touch_in(station)
    fail "Not enough funds available. Min fund is #{@min}." if @balance < Journey::MINIMUM_FARE
    charge_fare if @journeys.last.in_journey? 
    #charge_fare if  @journeylog.last.in_journey?
    @journeys.last.start_journey(station)
    #@journeylog.last.start_journey(station)
  end

  def touch_out(station)
    @journeys.last.end_journey(station)
    #@journeylog.last.end_journey(station)
    charge_fare
  end
  
  def charge_fare
    deduct(@journeys.last.fare)
    #deduct(@journeylog.last.fare)
    @journeys << Journey.new
    #@journeylog << Journey.new
  end

  private
  def deduct(amount)
    @balance -= amount
  end

end
