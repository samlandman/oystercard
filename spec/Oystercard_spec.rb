require 'oystercard'

describe Oystercard do
  let (:oyster) {Oystercard.new}

  describe 'initialize' do
    it "oyster is instance of Oystercard class" do
    expect(oyster).to be_an_instance_of(Oystercard)
    end
  end

  describe 'balance' do
    it "starting balance is equal to zero" do
    expect(oyster.balance).to eq(0)
    end
  end

  describe 'top_up()' do
    it "succesfully tops up card balance" do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end

    it "will not top up if the card will go over the limit" do
      limit = Oystercard::DEFAULT_LIMIT
      oyster.top_up(limit)
      expect { oyster.top_up(1) }.to raise_error ("Maximum limit is #{limit}.")
    end
  end

end
