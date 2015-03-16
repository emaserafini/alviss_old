module Thermostat
  class Status
    class << self
      def current *args
        new(*args).execute
      end
    end
  end

  attr_accessor :template_id, :recipient, :params

  def initialize thermostat_id, recipient, params = {}
    raise ArgumentError, "recipient need to be an Hash" unless recipient.is_a? Hash
    raise ArgumentError, "params need to be an Hash" unless params.is_a? Hash
    @template_id = template_id
    @recipient   = recipient
    @params      = params
  end

end
class Thermostatconfig

end

class Thermostat

  def sef.build(config)
    params = {
      current_temperature: config.
      mode: config.mode,
    }
    new(params)
  end

  def initialize

  end
end

thermostat = Thermostat.build(config)

thermostat.current_status