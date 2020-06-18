class Journeylog
  
  attr_reader :journeys
  
  def initialize
      
      @journeys = [Journey.new]
    
  end
  
  def return_journeys
    
    temp = ""
    @journeys.each { |journey| temp << journey.to_s }
    temp
  end
  
end