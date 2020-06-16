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
      expect {oyster.deduct 1}.to change { oyster.balance }. by -1
    end 
  end

  describe '#in_journey' do
    it 'traveller begins with NOT in journey' do
      expect(oyster).not_to be_in_journey
    end
  
    it 'traveller touches in' do
      oyster.touch_in
      expect(oyster).to be_in_journey
    end

    it 'traveller touches out' do
      oyster.touch_in
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
  
  end

 

end
