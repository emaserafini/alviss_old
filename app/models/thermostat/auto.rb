module Thermostat
  class Auto
    attr_accessor :current_temperature,
                  :weekly_schedule_data,
                  :scheduled_temperature,
                  :scheduled_status,
                  :latest_started_at,
                  :minimum_run,
                  :deviation_temperature

    def initialize current_temperature:, weekly_schedule_data:, options: {}
      @current_temperature   = current_temperature
      @weekly_schedule_data  = weekly_schedule_data
      @latest_started_at     = options[:latest_started_at]
      @minimum_run           = options[:minimum_run]
      @deviation_temperature = options[:deviation_temperature]
      set_scheduled
    end

    def weekly_schedule
      WeeklySchedule.new(weekly_schedule_data)
    end

    def current_activity
      weekly_schedule.current_activity
    end

    def set_scheduled
      @scheduled_temperature = current_activity.temperature
      @scheduled_status = current_activity.status
    end


    def status
      return :off if scheduled_status == 'off'
      return :unknown unless valid_temperatures?
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
      deviation_temperature.is_a? Float
    end

    def can_turn_off?
      return true unless minimum_run_enabled?
      (Time.now - latest_started_at) > minimum_run
    end

    def valid_temperatures?
      (setpoint_temperature.is_a? Float) && (current_temperature.is_a? Float)
    end
  end
end
