class Journey

MINIMUM_FARE = 1

  attr_reader :current_journey

  def initialize
    @current_journey = {}
  end

  def start_journey(station)
    set_entry(station)
  end

  def end_journey(station)
    set_exit(station)
  end

  def clear_history
    @current_journey = {}
  end

  private

  def set_entry(station)
    @current_journey[:entry_station] = station
  end
  def set_exit(station)
    @current_journey[:exit_station] = station
  end


end
