class Journey

MINIMUM_FARE = 1

  attr_reader :current_journey

  def initialize
    @current_journey = {}
  end

  def start_journey(station)
    set_entry(station)
  end

  private

  def set_entry(station)
    @current_journey[:entry_station] = station
  end


end
