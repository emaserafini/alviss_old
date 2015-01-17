class Thermostat
  attr_accessor :id, :mode, :status, :target_temperature, :latest_started_at, :latest_stopped_at

  def manager
    @manager ||= ThermostatManager.new(id: id, mode: mode, status: status, data: self)
  end

  def current_status
    manager.current_status
  end

  private

  def available_mode
    %w[:on :off :auto :manual]
  end

  def available_status
    %w[:on :off :unknown]
  end
end
