require 'oystercard'

describe Oystercard do
  let (:oyster) {Oystercard.new}

  describe 'initialize' do
    it "oyster is instance of Oystercard class" do
    expect(oyster).to be_an_instance_of(Oystercard)
    end
  end

  describe '#balance' do
    it "starting balance is equal to zero" do
    expect(oyster.balance).to eq(0)
    end
  end

  describe '#top_up()' do
    it "succesfully tops up card balance" do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end

    it "will not top up if the card will go over the limit" do
      limit = Oystercard::DEFAULT_LIMIT
      oyster.top_up(limit)
      expect { oyster.top_up(1) }.to raise_error ("Maximum limit is #{limit}.")
    end
  end

  describe '#deduct' do
  let(:station) {double "station"}
    it 'deducts money from the card' do
      oyster.top_up(20)
      oyster.touch_in(station)
      expect {oyster.touch_out(station)}.to change { oyster.balance }. by -1
    end 
  end

  describe '#in_journey' do
    let(:station) {double "station"}
    it 'traveller begins with NOT in journey' do
      expect(oyster).not_to be_in_journey
    end
  
    it 'traveller touches in' do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end

    it 'traveller touches out' do
      oyster.top_up(5)
      oyster.touch_in(station)
      oyster.touch_out(station)
      expect(oyster).not_to be_in_journey
    end
  end

  describe '#touch in without enough funds' do 
    let(:station) { double "station" }
    it 'it raises an error if not enought money in oyster' do
      expect{ subject.touch_in(station) }.to raise_error "Not enough funds available. Min fund is #{Journey::MINIMUM_FARE}."
    end
  end 

  describe 'charge on touch out' do
    let(:station) { double "station" }
    it 'deduct min fare after touched out for correct journey' do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect { oyster.touch_out(station) }.to change { oyster.balance }.by (-Journey::MINIMUM_FARE)
    end
    it 'deduct penalty fare after touch in twice' do
      oyster.top_up(10)
      oyster.touch_in(station)
      expect { oyster.touch_in(station) }.to change { oyster.balance }.by (-Journey::PENALTY_FARE)
    end
    it 'deduct penalty fare after touch out twice' do
      oyster.top_up(10)
      oyster.touch_in(station)
      oyster.touch_out(station)  
      expect { oyster.touch_out(station) }.to change { oyster.balance }.by (-Journey::PENALTY_FARE)
    end
  end

  describe '#touch-in' do
    it 'oyster.touch_in(station) to accept 1 arguement' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
    it 'creates a new journey if already in a journey' do
      oyster.top_up(5)
      oyster.touch_in("test_station_1")
      oyster.touch_in("test_station_2")
      expect(oyster.journeys.count).to eq(2)
    end
  end

  describe '#journeys' do
  let(:station) { double "station" }
    it 'subject responds to' do
      expect(subject).to respond_to(:journeys)
    end
    it 'has one blank journey on initialize' do
      expect(subject.journeys.count).to eq(1)
    end
    it 'has one journey and one blank journey when touch_in and touch_out complete' do
      oyster.top_up(5)
      oyster.touch_in(station)
      oyster.touch_out(station)
      expect(oyster.journeys.count).to eq(2)
    end
    it 'stores the name store the name of station upon touch in' do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect(oyster.journeys.last.entry_station).to eq(station)
    end
    it 'exit_station recorded in journeys on touch_out' do
      oyster.top_up(5)
      oyster.touch_in(station)
      oyster.touch_out(station)
      expect(oyster.journeys[-2].exit_station).to eq(station)
    end
  end

  describe '#touch_out' do
    it 'responds to one argument' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end
  end 
end
