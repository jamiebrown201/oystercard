require 'journey'

describe Journey do

subject(:journey) {described_class.new}
let(:station) {double :station}

  context 'when a journey begins' do
    describe '#Start_journey' do
      it 'it should log the entry station' do
        journey.start_journey(station)
        expect(journey.current_journey[:entry_station]).to eq station
      end
    end
  end


end
