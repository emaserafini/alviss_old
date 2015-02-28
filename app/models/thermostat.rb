class Thermostat < ActiveRecord::Base
  enum active_mode: [ :inactive, :manual, :auto ]

  def operating_mode
    raise "Not implemended mode for: #{active_mode}" unless available_modes.include? active_mode
    "#{active_mode}_mode".camelize.constantize
  end

  def get_status
    operating_mode.get_status(id)
  end


  private

  def available_modes
    [ :inactive, :manual, :auto ]
  end
end
