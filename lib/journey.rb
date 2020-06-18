

class Journey
  attr_reader :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def start_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end
  
  def in_journey?
    !@exit_station && !!@entry_station
  end

  def fare
    (!!@exit_station && !!@entry_station) ? MINIMUM_FARE : PENALTY_FARE
  end
  
end