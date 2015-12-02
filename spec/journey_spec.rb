require 'journey'

describe Journey do

subject(:journey) {described_class.new}
let(:station) {double :station}

  context 'when a journey begins' do
    describe '#Start_journey' do
      it 'should log the entry station' do
        journey.start_journey(station)
        expect(journey.current_journey[:entry_station]).to eq station
      end
    end
  context 'when a journey ends' do
    describe '#end_jouney' do
      it 'should log the exit station'do
        journey.end_journey(station)
        expect(journey.current_journey[:exit_station]).to eq station
      end
    end
  end
  end



  it 'is initially not in a journey' do
    expect(journey.current_journey[:entry_station]).to eq(nil)
  end


  it 'clears the entry station upon touch out' do
    journey.start_journey(station)
    journey.end_journey(station)
    journey.clear_history
    expect(journey.current_journey[:entry_station]).to eq nil
  end

end
