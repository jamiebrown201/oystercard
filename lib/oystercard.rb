require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6
  FARE = 1

  attr_reader :balance, :journey, :journey_log
  # :journey_history,

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
    # @journey_history = []
    @journey = Journey.new
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if max_balance_exceeded?(value)
    @balance += value
  end

  def touch_in(station)
    calculate_fare_entry
    journey.clear_history
    fail "Insufficent funds: top up" if below_minimum_balance?
    journey.start_journey(station)
  end

  def touch_out(station)
    journey.end_journey(station)
    calculate_fare_out
    journey_log.history(journey.current_journey)
    # @journey_history << current_journey
    journey.clear_history
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

  def calculate_fare_out
    journey.current_journey[:entry_station] == nil ? deduct(PENALTY_FARE) : deduct(FARE)
  end

  def calculate_fare_entry
    deduct(PENALTY_FARE) if journey.current_journey[:exit_station] == nil
  end

end
