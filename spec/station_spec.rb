require 'station'
describe Station do
  let(:station) {Station.new("London Bridge",1)}
  describe '#name' do

    it 'has a name' do
    expect(station).to respond_to(:name)
    end

    it 'create a name on initialize' do
      expect(station.name).to eq("London Bridge")    
    end 
  end

  describe '#zone' do
    it 'has a zone' do
    expect(station).to respond_to(:zone)
    end

    it 'create a zone on initialize' do
      expect(station.zone).to eq(1)    
    end
  end

end