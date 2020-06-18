require_relative 'journey'

class Journeylog
  
  attr_reader :journeys
  
  def initialize
      
      @journeys = [Journey.new]
    
  end
  
  def return_journeys
    
    temp = ""
    @journeys.each { |journey| temp << "#{journey.entry_station.name.to_s} to #{journey.exit_station.name.to_s}"}
    temp
  end
  
end