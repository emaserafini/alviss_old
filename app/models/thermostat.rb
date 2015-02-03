class Thermostat
  attr_accessor :mode

  def initialize
    @mode = :inactive
  end

  def inactive?
    true
  end

  def current_status
    case mode
    when :inactive
      :unknown
    when :manual
      :on
    end
  end
end
