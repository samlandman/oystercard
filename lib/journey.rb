

class Journey
  attr_reader :entry_station, :exit_station

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
    (!!@exit_station && !!@entry_station) ? 1 : 6
  end
  
end