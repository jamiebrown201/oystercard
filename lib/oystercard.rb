require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :journey_history, :journey

  def initialize(journey)
    @balance = 0
    @journey_history = []
    @journey = journey
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if max_balance_exceeded?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if below_minimum_balance?
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    @journey_history << journey.current_journey
    journey.clear_history
    deduct(MINIMUM_BALANCE)
  end


  private
  def max_balance_exceeded?(value)
    value + balance > MAXIMUM_BALANCE
  end

  def below_minimum_balance?
    balance < MINIMUM_BALANCE
  end

  def in_journey?
    !!@current_journey[:entry_station]

  end


  def deduct(value)
    @balance -= value
  end

end
