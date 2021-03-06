describe "Feature Tests" do

  let(:card) {Oystercard.new}
  let(:journey) {Journey.new}
  let(:journey_log) {JourneyLog.new}
  let(:rand_number) {rand(20..40)}
  let(:station) {Station.new('Test Station', 3)}
  let(:maximum_balance) {Oystercard::MAXIMUM_BALANCE}
  let(:minimum_balance) {Oystercard::MINIMUM_BALANCE}

  describe 'Oystercard' do
    describe '#initialize Oystercard' do

    describe 'behaviour of balance on the card' do
      it 'creates a card with a balance' do
        expect(card.balance).to eq 0
      end

      it 'tops up the card by a value and returns the balance' do
        expect{card.top_up(1)}.to change{card.balance}.by(1)
      end

      it 'will not allow balance to exceed maximum balance' do
        card.top_up(maximum_balance)
        expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
      end
    end

    describe '#touch_in' do
      before do
        card.top_up(rand_number)
      end
      it 'allows a card to touch in and begin journey if balance greater than minimum fare' do
        card.touch_in(station)
        expect(card.journey_klass.current_journey[:entry_station]).to eq(station)
      end

      it 'raise error if card balance is zero' do
        card.top_up(-90)
        expect{card.touch_in(station)}.to raise_error "Insufficent funds: top up"
      end

      it 'remembers the station the journey started from' do
        card.touch_in(station)
        expect(card.journey_klass.current_journey[:entry_station]).to eq station
      end

      it 'charges a penalty fair if failed to touch_out' do
        card.touch_in(station)
        expect{card.touch_in(station)}.to change{card.balance}.by (-Oystercard::PENALTY_FARE)
      end

  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out
    end

    describe '#touch_out' do
      before do
        card.top_up(rand_number)
      end
      it 'allows a card to touch out and end a journey' do
          card.touch_out(station)
          expect(journey.current_journey[:entry_station]).to eq(nil)
      end

      it 'charges customer when they tap out' do
        card.touch_in(station)
        expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_balance)
      end

      it 'clears the entry station upon touch out' do
        card.top_up(minimum_balance)
        card.touch_in(station)
        card.touch_out((station))
        expect(journey.current_journey[:entry_station]).to eq nil
      end

    end

    describe 'previous journeys' do
      it 'can recall all previous journeys' do
        entry_station = double(:station)
        exit_station = double(:station)
        card.top_up(rand_number)
        card.touch_in(entry_station)
        card.touch_out(exit_station)
        expect(card.journey_log_klass.journey_history[0][:exit_station]).to eq exit_station
      end
    end

    it 'charges a penalty fair if failed to touch_in' do
      expect{card.touch_out(station)}.to change{card.balance}.by (-Oystercard::PENALTY_FARE)
    end
  end

  describe 'Station' do
    it 'should return the station name' do
      expect(station.name).to eq 'Test Station'
    end

    it 'should return the station zone' do
      expect(station.zone).to eq 3
    end

  end

  describe 'Journey' do
    it 'is initially not in a journey' do
      expect(journey.current_journey[:entry_station]).to eq(nil)
    end
  end



end
end
