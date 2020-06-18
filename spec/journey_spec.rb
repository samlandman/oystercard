require 'journey'

describe Journey do
  let (:station) { Station.new("London Bridge", 1) }
  let (:journey) { Journey.new }
  
  describe 'initialize' do
    it "subject is an instance of Journey class" do
      expect(journey).to be_an_instance_of(Journey)
    end
  end
  describe '#start_journey' do
    it 'is stores the value of entry_station when start journey' do
      journey.start_journey(station)
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
      journey.start_journey(station)
      expect(journey).to be_in_journey
    end
    it 'returns false if not in journey' do
      journey.end_journey(station)
      expect(journey).not_to be_in_journey
    end
  end

  describe '#fare' do
    it 'returns a normal fare' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.fare).to eq(1)
    end
    it 'returns a penalty fare if not in_journey? and end_journey called' do
    journey.end_journey(station)
    expect(journey.fare).to eq(6)
    end
  end
  
end


