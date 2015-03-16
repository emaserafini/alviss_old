class Manual
  attr_accessor :current, :setpoint, :deviation, :running, :mode

  SUPPORTED_MODE = ['heat', 'cool']

  def initialize temperature:, setpoint:, mode:, deviation:, running:, options: {}
    @temperature       = temperature
    @setpoint          = setpoint
    @mode              = mode
    @deviation         = deviation || 0
    @running           = running
    @latest_started_at = options[:latest_started_at]
    @minimum_run       = options[:minimum_run] || 0
  end

  def self.status
    new().status
  end

  def status
    return 'unknown' unless valid_temperatures?
    return :on unless can_turn_off?
    on? ? 'on' : 'off'
  end

  def on?
    setpoint_range.include?(temperature) ? running : check
  end

  def setpoint_range
    (setpoint - deviation..setpoint + deviation)
  end

  def check
    mode == 'heat' ? (temperature <= setpoint) : (temperature >= setpoint)
  end

  def can_turn_off?
    return true unless minimum_run_enabled?
    (Time.now - latest_started_at) > minimum_run
  end

  private

  def minimum_run_enabled?
    (minimum_run.is_a? Integer) && (minimum_run > 0) && (latest_started_at.is_a? Time)
  end

  def valid_temperatures?
    (setpoint.is_a? Float) && (temperature.is_a? Float)
  end
end
