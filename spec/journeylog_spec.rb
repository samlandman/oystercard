require 'journeylog'

describe Journeylog do
  let (:station) { Station.new("London Bridge", 1) }
  let (:station2) { Station.new("Westminster", 1) }
  let (:journeylog) { Journeylog.new }
  
  describe '#initialize' do
    it "subject is an instance of Journeylog class" do
      expect(subject).to be_an_instance_of(Journeylog)
    end
    it 'is initialized with an array to store journeys' do
      expect(subject).to respond_to(:journeys)
    end
  end
  
  describe '#return_journeys' do
    it 'returns the list of journeys' do
      journeylog.journeys.last.start_journey(station)
      journeylog.journeys.last.end_journey(station2)
      expect(journeylog.return_journeys).to eq("London Bridge to Westminster")
    end
  end
  
  #describe '@journeys' do

  #end
end