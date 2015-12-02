require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new(journey)}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}
  let(:minimum_balance) {Oystercard::MINIMUM_BALANCE}
  let(:station) {double :station}
  let(:journey) {double :journey, start_journey: station, end_journey: station, current_journey: nil, clear_history: {} }


  describe '#initialize' do


    it 'has an empty journey list' do
      expect(card.journey_history).to eq []
    end

  end

  describe '#balance' do
    it 'creates a card with a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'tops up the card by a value and returns the balance' do
      expect { card.top_up(1) }.to change { card.balance }.by 1
    end

    it 'will not allow balance to exceed maximum balance' do
      card.top_up(maximum_balance)
      expect{card.top_up(1)}.to raise_error("Maximum balance of £#{maximum_balance} exceeded")
    end
  end

  describe '#touch_in' do

    it 'raises error if insufficent funds' do
      expect{ card.touch_in(station) }.to raise_error "Insufficent funds: top up"
    end

  end

  describe '#touch_out' do
    it 'charges customer when they tap out' do
      expect{card.touch_out((station))}.to change{card.balance}.by(-minimum_balance)
    end

  end

  describe 'checking journey history' do
    context 'completed journeys' do
    before do
      allow(journey).to receive(:current_journey).and_return({entry_station: station, exit_station: station})
    end

      it 'can recall previous journeys' do
        card.top_up(minimum_balance)
        card.touch_in(station)
        card.touch_out(station)
        expect(card.journey_history).to eq [{entry_station: station, exit_station:station}]
      end
    end
  end
end
