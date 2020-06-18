require 'journeylog'

describe Journeylog do
  let (:station) { Station.new("London Bridge", 1) }
  #let (:journey) { Journey.new }
  
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
      subject.journeys.last.start_journey(station)
      subject.journeys.last.end_journey(station)
      expect(subject.return_journeys).to eq('[#<Journey:0x00000000012ca078 @entry_station=#<Station:0x00000000012c9f38 @name="London Bridge", @zone=1>, @exit_station=#<Station:0x00000000012c9f38 @name="London Bridge", @zone=1>>]')
    end
  end
  
  #describe '@journeys' do

  #end
end