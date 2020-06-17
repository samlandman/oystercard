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
    it 'deducts money from the card' do
      oyster.top_up(20)
      expect {oyster.touch_out}.to change { oyster.balance }. by -1
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
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
  end

  describe '#touch in without enough funds' do 
    let(:station) { double "station" }
    it 'it raises an error if not enought money in oyster' do
      min = Oystercard::MINIMUM
      expect{ subject.touch_in(station) }.to raise_error "Not enough funds available. Min fund is #{min}."
    end
  end 

  describe 'charge on touch out' do
    let(:station) { double "station" }
    it 'deduct min fare after touched out' do
      oyster.top_up(5)
      oyster.touch_in(station)
      # oyster.touch_out
      expect { oyster.touch_out }.to change { oyster.balance }.by (-Oystercard::MIN_CHARGE)
    end
  end

  describe '#touch-in' do
    it 'oyster.touch_in(station) to accept 1 arguement' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end
  end

  describe '#entry_station' do
    let(:station) {double "station"}
    it 'responds to entry station' do
      expect(oyster).to respond_to(:entry_station) 
    end

    it 'stores the name store the name of station upon touch in' do
      oyster.top_up(5)
      oyster.touch_in(station)
      expect(oyster.entry_station).to eq(station)
    end
   
    it 'sets entry station to Nil upon touch out' do
       oyster.top_up(5)
       oyster.touch_in(station)
       oyster.touch_out
       expect(oyster.entry_station).to eq(nil)
    end

  end

end
