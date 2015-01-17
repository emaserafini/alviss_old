class Thermostat
  attr_accessor :id, :mode, :status, :target_temperature, :latest_started_at, :latest_stopped_at

  def check_status
    status == :on ? :on : :off
  end
end
