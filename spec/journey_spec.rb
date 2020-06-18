require 'journey'

describe Journey do
  let (:station) {Station.new("London Bridge", 1)}
  let (:journey) {Journey.new(station)}
  
  describe 'initialize' do
    it "subject is an instance of Journey class" do
      expect(journey).to be_an_instance_of(Journey)
    end
    it 'is stores the value of entry_station on initialize' do
      expect(journey.entry_station).to eq (station)
    end
  end
  
  describe '#end_journey' do
    it 'stores the variable of exit_station when the journey is ended' do
      journey.end_journey(station)
      expect(journey.exit_station).to eq (station)
    end
  end
  
  describe '#in_journey?' do
    it 'returns true if in journey' do
      expect(journey).to be_in_journey
    end
    it 'returns false if not in journey' do
      journey.end_journey(station)
      expect(journey).not_to be_in_journey
    end
  end
  
  
end


