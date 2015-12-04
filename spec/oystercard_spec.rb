require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new}
  let(:rand_number) {rand(20..50)}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE}
  let(:minimum_balance) {Oystercard::MINIMUM_BALANCE}
  let(:fare) {Oystercard::FARE}
  let(:station) {double :station}
  let(:journey) {double :journey, start_journey: station, end_journey: station, current_journey: nil, clear_history: {} }


  describe '#initialize' do

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

    it 'deducts penalty fair when not touched out' do
      card.top_up(rand_number)
      card.touch_in(station)
      expect{card.touch_in(station)}.to change{card.balance}.by (-Oystercard::PENALTY_FARE)
    end

  end

  describe '#touch_out' do
    it 'charges customer when they tap out' do
      card.top_up(40)
      card.touch_in(station)
      expect{card.touch_out((station))}.to change{card.balance}.by(-fare)
    end

    it 'deducts penalty fair when not touched in' do
      card.top_up(rand_number)
      expect{card.touch_out(station)}.to change{card.balance}.by (-Oystercard::PENALTY_FARE)
    end

  end

  describe 'checking journey history' do
    context 'completed journeys' do
    before do
      allow(journey).to receive(:current_journey).and_return({entry_station: station, exit_station: station})
    end

    end
  end
end
