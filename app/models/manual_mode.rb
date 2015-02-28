class ManualMode < ActiveRecord::Base
  belongs_to :thermostat
  belongs_to :feed_temperature, class_name: 'Feed', foreign_key: 'feed_temperature_id'
  belongs_to :feed_status, class_name: 'Feed', foreign_key: 'feed_status_id'

  def current_temperature
    feed_temperature.current_data
  end

  def latest_started_at

  end

  def status
    return :unknown unless valid_temps?
    return :on unless can_turn_off?
    target_temperature <= current_temperature ? :off : :on
  end

  def target_temperature
    return setpoint_temperature unless deviation_enabled?
    (setpoint_temperature <= current_temperature) ? (setpoint_temperature + deviation_temperature/2) : (setpoint_temperature - deviation_temperature/2)
  end

  def minimum_run_enabled?
    (minimum_run.is_a? Integer) && (minimum_run > 0) && (latest_started_at.is_a? Time)
  end

  def deviation_enabled?
    deviation_temperature.is_a? BigDecimal
  end

  def can_turn_off?
    return true unless minimum_run_enabled?
    (Time.now - latest_started_at) > minimum_run
  end


  private

  def valid_temps?
    (setpoint_temperature.is_a? BigDecimal) && (current_temperature.is_a? BigDecimal)
  end
end
